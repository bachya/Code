<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <!-- Identity Transform -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="output | var">
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="*[starts-with(name(), 'field')]">
    <xsl:element name="{@name}">
      <xsl:value-of select="string" />
    </xsl:element>
  </xsl:template>
    
</xsl:stylesheet>