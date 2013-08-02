<?xml version="1.0"?>
<xsl:stylesheet
	 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:exsl="http://exslt.org/common"
	 exclude-result-prefixes="exsl"
	 version="1.0">
  <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>
  
  <xsl:variable name="vFieldNames">
  	 <name oldName="Title1" newName="title" />
  	 <name oldName="Sub-title" newName="subtitle" />
  	 <name oldName="Filename" newName="filename" />
  	 <name oldName="Display Scheduled Start Date" newName="startDate" />
  	 <name oldName="Display Scheduled End Date" newName="endDate" />
  	 <name oldName="Display Scheduled End Time" newName="endTime" />
  </xsl:variable>
  
  <xsl:template match="/">
  	 <events>
  	 	 <xsl:apply-templates select="*/*/item" />
  	 </events>
  </xsl:template>
  
  <xsl:template match="item">
  	 <event>
  	 	 <category>
  	 	 	 <xsl:value-of select="title" />
  	 	 </category>
  	 	 <xsl:apply-templates select="exsl:node-set($vFieldNames)/*">
  	 	 	 <xsl:with-param name="pDescriptionText" select="current()/description" />
  	 	 </xsl:apply-templates>
  	 </event>
  </xsl:template>
  
  <xsl:template match="name">
  	 <xsl:param name="pDescriptionText" />
  	 <xsl:variable name="vRough" select="substring-before(substring-after($pDescriptionText, @oldName), 'div')"/>
  	 <xsl:variable name="vValue" select="substring-before(substring-after($vRough, '&gt;'), '&lt;')"/>
  	 <xsl:element name="{@newName}">
  	 	 <xsl:value-of select="normalize-space($vValue)" />
  	 </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
