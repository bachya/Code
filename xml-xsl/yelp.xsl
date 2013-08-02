<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  exclude-result-prefixes="exsl"
  version="1.0">
  <xsl:output omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>
  
  <!-- NAMED: flatten-elements: takes a two-level structure and creates a delimited string of its values -->
  <xsl:template name="flatten-elements">
    <xsl:param name="pNodes" />
    <xsl:param name="pDelimiter" />
    
    <xsl:for-each select="exsl:node-set($pNodes)/name">
      <xsl:value-of select="." />
      <xsl:if test="not(position() = last())">
        <xsl:value-of select="$pDelimiter" />
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  
  <!-- Identity Template: copies everything as-is -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>
  
  <!-- Copies <businesse> elements and children while adding two new fields: <category-search> and <neighborhood-search> -->
  <xsl:template match="businesse">
    
    <!-- This can be changed to pick the delimiter you'd like -->
    <xsl:variable name="vDelimiter" select="'|'" />
    
    <xsl:copy>
      <xsl:apply-templates />
      <category-search>
        <xsl:call-template name="flatten-elements">
          <xsl:with-param name="pNodes" select="categories/categorie" />
          <xsl:with-param name="pDelimiter" select="$vDelimiter" />
        </xsl:call-template>
      </category-search>
      <neighborhood-search>
        <xsl:call-template name="flatten-elements">
          <xsl:with-param name="pNodes" select="neighborhoods/neighborhood" />
          <xsl:with-param name="pDelimiter" select="$vDelimiter" />
        </xsl:call-template>
      </neighborhood-search>
    </xsl:copy>
  </xsl:template>
  
  <!-- Cuts out <reviews> elements and their children -->
  <xsl:template match="reviews" />
  
</xsl:stylesheet>