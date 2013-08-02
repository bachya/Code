<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>


  <!-- Identity Transform - copies everything as-is -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Remove <output> and <var> elements, but process -->
  <!-- their children -->
  <xsl:template match="output | var">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- For every <field> element, create a new element -->
  <!-- comprised of the lowercase version of @name -->
  <xsl:template match="field">
    <xsl:element name="{translate(@name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')}">
      <xsl:value-of select="string"/>
    </xsl:element>
  </xsl:template>
    
</xsl:stylesheet>