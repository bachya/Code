#createdb.ps1

# Used to automate the creation/pairing of a new FWi Cloud
# Database and user.

# Get parameters from the command line

Add-Type -AssemblyName "Microsoft.SqlServer.Smo, Version=10.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
Add-Type -AssemblyName "Microsoft.SqlServer.SmoExtended, Version=10.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"

######################################################
# EDIT THESE VALUES IF YOU'D LIKE
######################################################
[string]$password = "fourwinds";
$roles = @("db_owner")
######################################################
# DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU'RE DOING!
######################################################

function createNewDatabase([string] $inst, [string] $dbToCreate) {
  # Connect to the SQL Server instance
  $s = new-object ('Microsoft.SqlServer.Management.Smo.Server') $inst

  # Instantiate the database object and add the filegroups
  $db = new-object ('Microsoft.SqlServer.Management.Smo.Database') ($s, $dbToCreate)
  $sysfg = new-object ('Microsoft.SqlServer.Management.Smo.FileGroup') ($db, 'PRIMARY')
  $db.FileGroups.Add($sysfg)
  $appfg = new-object ('Microsoft.SqlServer.Management.Smo.FileGroup') ($db, 'AppFG')
  $db.FileGroups.Add($appfg)

  # Create the file for the system tables
  $syslogname = $dbToCreate + '_SysData'
  $dbdsysfile = new-object ('Microsoft.SqlServer.Management.Smo.DataFile') ($sysfg, $syslogname)
  $sysfg.Files.Add($dbdsysfile)
  $dbdsysfile.FileName = $s.Information.MasterDBPath + '\' + $syslogname + '.mdf'
  $dbdsysfile.Size = [double](5.0 * 1024.0)
  $dbdsysfile.GrowthType = 'None'
  $dbdsysfile.IsPrimaryFile = 'True'

  # Create the file for the Application tables
  $applogname = $dbToCreate + '_AppData'
  $dbdappfile = new-object ('Microsoft.SqlServer.Management.Smo.DataFile') ($appfg, $applogname)
  $appfg.Files.Add($dbdappfile)
  $dbdappfile.FileName = $s.Information.MasterDBPath + '\' + $applogname + '.ndf'
  $dbdappfile.Size = [double](25.0 * 1024.0)
  $dbdappfile.GrowthType = 'Percent'
  $dbdappfile.Growth = 25.0
  $dbdappfile.MaxSize = [double](100.0 * 1024.0)

  # Create the file for the log
  $loglogname = $dbToCreate + '_Log'
  $dblfile = new-object ('Microsoft.SqlServer.Management.Smo.LogFile') ($db, $loglogname)
  $db.LogFiles.Add($dblfile)
  $dblfile.FileName = $s.Information.MasterDBLogPath + '\' + $loglogname + '.ldf'
  $dblfile.Size = [double](10.0 * 1024.0)
  $dblfile.GrowthType = 'Percent'
  $dblfile.Growth = 25.0

  # Create the database
  $db.Create()

  # Set the default filegroup to AppFG
  $appfg = $db.FileGroups['AppFG']
  $appfg.IsDefault = $true
  $appfg.Alter()
  $db.Alter()

  # Create the login name
  $loginName = $dbToCreate + '_user'

  # CAREFUL: if the login already exists, it will be dropped
  if ($s.Logins.Contains($loginName)) {
  	$s.Logins[$loginName].Drop(); 
  	return;
  }

  $login = New-Object ('Microsoft.SqlServer.Management.Smo.Login') $s, $loginName

  # Set it to be a SQL Authentication login
  $login.LoginType = [Microsoft.SqlServer.Management.Smo.LoginType]::SqlLogin;

  # Disable enforcing of password policy
  $login.PasswordPolicyEnforced = $false
  $login.Create($password);

  # Refresh the server's login list so it contains the SID
  $s.Logins.Refresh();
  $login = $s.Logins[$loginName]

  # Create a new user based on our new login
  $user = New-Object('Microsoft.SqlServer.Management.Smo.User') $db, $login.Name
  $user.Login = $login.Name
  $user.create();

  # Assign the pre-specified roles to this user for the new DB
  foreach ($role in $roles) {
  	$role = $db.Roles[$role]
  	$role.AddMember($user.name)
  }
}

function copyDatabaseTables([string] $source, [string] $destination) {
  $s = new-object ('Microsoft.SqlServer.Management.Smo.Server') $inst
  
  $transfer = new-object ('Microsoft.SqlServer.Management.Smo.Transfer') ($s.Databases[$source])
  $transfer.CopyAllObjects = $true;
  $transfer.CopyAllUsers = $true;
  $transfer.DestinationDatabase = $destination.Name;
  $transfer.DestinationServer = $s.Name;
  $transfer.CopySchema = $true;
  $transfer.CopyData = $true;
  $transfer.TransferData();
}

# Make sure all of our parameters are present
switch ($args.Length)  { 
    2 {
      [string] $instance = $args[0]
      [string] $databaseToCreate = $args[1]

      createNewDatabase $instance $databaseToCreate
    } 
    3 {
      [string] $instance = $args[0]
      [string] $databaseToCreate = $args[1]
      [string] $databaseToLoad = $args[2]

      createNewDatabase $instance $databaseToCreate
      copyDatabaseTables $databaseToLoad $databaseToCreate
    } 
    default {
      write-output "Usage: $($MyInvocation.MyCommand.Path)  [Server Instance] [Database Name] ([Database-To-Copy-From])"
    	return
    }
}