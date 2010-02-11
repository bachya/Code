our %packages = (
  bash => {
    files => {
      aliases   => '.bash_aliases',
      bashrc    => '.bashrc',
      functions => '.bash_functions',
      login     => '.bash_login',
      profile   => '.profile'
    }
  },
  git => {
    files => {
      config    => '.gitconfig',
      functions => '.bash_functions'      
    },
    prereqs => [
      'bash'
    ]
  }
);