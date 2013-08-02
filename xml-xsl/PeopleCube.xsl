<?xml version="1.0"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
  
  	<xsl:template name="formatDateTime">
  		<xsl:param name="dateTime" />
    	<xsl:value-of select="concat(
    		substring($dateTime, 0, 5), '-',
    		substring($dateTime, 5, 2), '-',
    		substring($dateTime, 7, 2), ' ',
    		substring($dateTime, 10, 2), ':'
    		substring($dateTime, 12, 2), ':'
    		substring($dateTime, 14, 2))" />
  	</xsl:template>
  
	<xsl:template match="/">
		<events>
			<xsl:for-each select="//*[local-name() = 'reservation']">

				<xsl:variable
				   name="startDateTime"
     		       select="*[local-name() = 'meeting_start']"/>

     			<xsl:variable
				   name="endDateTime"
     		       select="*[local-name() = 'meeting_end']"/>

     			<xsl:variable
				   name="startBusyDateTime"
     		       select="*[local-name() = 'busy_start']"/>

     			<xsl:variable
				   name="endBusyDateTime"
     		       select="*[local-name() = 'busy_end']"/>
     		       
     			<xsl:variable
				   name="description"
     		       select="*[local-name() = 'description']"/>
			
				<xsl:for-each select="*[local-name() = 'resources']/*[local-name() = 'resource']">
					<event>
						<location>
							<xsl:value-of select="*[local-name() = 'location']/*[local-name() = 'location_name']"/>
						</location>
						<roomName>
							<xsl:value-of select="*[local-name() = 'resource_name']"/>
						</roomName>
						<startTime>
							<xsl:call-template name="formatDateTime">
              					<xsl:with-param name="dateTime" select="$startDateTime" />
            				</xsl:call-template>
						</startTime>
						<endTime>
							<xsl:call-template name="formatDateTime">
              					<xsl:with-param name="dateTime" select="$endDateTime" />
            				</xsl:call-template>
						</endTime>
						<startBusyTime>
							<xsl:call-template name="formatDateTime">
              					<xsl:with-param name="dateTime" select="$startBusyDateTime" />
            				</xsl:call-template>
						</startBusyTime>
						<endBusyTime>
							<xsl:call-template name="formatDateTime">
              					<xsl:with-param name="dateTime" select="$endBusyDateTime" />
            				</xsl:call-template>
						</endBusyTime>
						<description>
							<xsl:value-of select="$description"/>
						</description>
					</event>
				</xsl:for-each>
			</xsl:for-each>
		</events>
	</xsl:template>
</xsl:stylesheet>