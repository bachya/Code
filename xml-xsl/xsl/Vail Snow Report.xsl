<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  exclude-result-prefixes="exsl">
  <xsl:output omit-xml-declaration="yes" indent="yes" />
  <xsl:strip-space elements="*"/>
 
  <!-- Defines the fields to create for all of the description elements -->
  <!-- Position is important here, so make sure they're in the correct order -->
  <xsl:variable name="descriptionFields">
    <descriptionField>NewSnowInLast24Hours</descriptionField>
    <descriptionField>NewSnowInLast48Hours</descriptionField>
    <descriptionField>NewSnowInLast7Days</descriptionField>
    <descriptionField>SnowConditions</descriptionField>
    <descriptionField>ForecastToday</descriptionField>
    <descriptionField>SnowBase</descriptionField>
    <descriptionField>MidMountain</descriptionField>
    <descriptionField>LiftsOpen</descriptionField>
  </xsl:variable>
  
  <!-- Tokenize template - creates an XML nodeset from a delimited string -->
  <xsl:template name="tokenize">
    <xsl:param name="pText"/>
    <xsl:param name="pDelimiter" select="' '" />
    <xsl:choose>
      <xsl:when test="contains($pText, $pDelimiter)">
        <token>
          <xsl:value-of select="substring-before($pText, $pDelimiter)" />
        </token>
        <xsl:call-template name="tokenize">
          <xsl:with-param name="pText" select="substring-after($pText, $pDelimiter)" />
          <xsl:with-param name="pDelimiter" select="$pDelimiter" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$pText">
        <token>
          <xsl:value-of select="$pText"/>
        </token>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
 
  <!-- STYLESHEET BEGINS HERE -->
  <!-- Identity Template - copies all elements as-is -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>
  
  <!-- <description> template - for all elements separated by '&lt;br/&gt;', split their names and values -->
  <xsl:template match="item/description">
    <xsl:copy>
      <xsl:apply-templates />
    </xsl:copy>
    <xsl:variable name="vDescriptions">
      <xsl:call-template name="tokenize">
        <xsl:with-param name="pText" select="." />
        <xsl:with-param name="pDelimiter" select="'&lt;br/&gt;'" />
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:for-each select="exsl:node-set($vDescriptions)/token">
      <xsl:variable name="vPosition" select="position()" />
      <xsl:element name="{document('')/*/xsl:variable[@name='descriptionFields']/descriptionField[$vPosition]}">
        <xsl:value-of select="substring-after(substring-after(text(), ':'), ' ')" />
      </xsl:element>
    </xsl:for-each>
  </xsl:template>
 
</xsl:stylesheet>