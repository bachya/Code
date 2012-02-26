<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  exclude-result-prefixes="exsl"
  version="1.0">
  <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <!-- TEMPLATE #1: Identity Template -->
  <!-- This template will get overridden by subsequent templates -->
  <xsl:template match="node()|@*">
      <xsl:copy>
          <xsl:apply-templates select="node()|@*"/>
      </xsl:copy>
  </xsl:template>

  <!-- TEMPLATE #2: Generic RECIPE Template -->
  <xsl:template match="RECIPE">
    <xsl:copy>
      
      <!-- Before adding any new elements, process template that turns all <RECIPE> attributes to child elements -->
      <xsl:apply-templates select="@*"/>
      
      <!-- Create a pseudo-"table" that holds nutrient keys, values, and units -->
      <xsl:variable name="nutrients-table-tmp">
        <xsl:call-template name="tokenize-table">
          <xsl:with-param name="text" select="../NUTRIENTS/text()"/>
          <xsl:with-param name="delimiter-row" select="'|'"/>
          <xsl:with-param name="delimiter-col" select="'~'"/>
        </xsl:call-template>
      </xsl:variable>
      
      <xsl:variable name="nutrients-table" select="exsl:node-set($nutrients-table-tmp)/table"/>

      <!-- Grab all nutrient values from RECIPE/@nutrients -->
      <xsl:variable name="nutrients">
        <xsl:call-template name="tokenize">
          <xsl:with-param name="text" select="@nutrients"/>
          <xsl:with-param name="delimiter" select="'|'"/>
        </xsl:call-template>
      </xsl:variable>

      <!-- Create new elements at the end of nutrientsuncertain -->
      <xsl:for-each select="exsl:node-set($nutrients)/token">
        <xsl:variable name="pos" select="position()"/>
        <xsl:variable name="value" select="text()"/>
        <xsl:variable name="row" select="$nutrients-table/row[$pos]"/>

        <xsl:variable name="name" select="$row/cell[1]/text()"/>
        <xsl:variable name="description" select="$row/cell[2]/text()"/>
        <xsl:variable name="unit" select="$row/cell[3]/text()"/>

        <xsl:element name="{$name}">
          <xsl:attribute name="unit">
            <xsl:value-of select="$unit"/>
          </xsl:attribute>
          <xsl:attribute name="description">
            <xsl:value-of select="$description"/>
          </xsl:attribute>
          <xsl:value-of select="$value"/>
        </xsl:element>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>

  <!-- TEMPLATE #3: Turn all attributes of each <RECIPE> into child elements -->
  <xsl:template match="RECIPE/@*">
    <xsl:element name="{name()}">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <!-- TEMPLATE #4: Takes a delimited string and returns a nodeset of its elements -->
  <xsl:template name="tokenize">
    <xsl:param name="text"/>
    <xsl:param name="delimiter" select="' '"/>
    <xsl:choose>
      <xsl:when test="contains($text,$delimiter)">
        <xsl:element name="token">
          <xsl:value-of select="substring-before($text,$delimiter)"/>
        </xsl:element>
        <xsl:call-template name="tokenize">
          <xsl:with-param name="text" select="substring-after($text,$delimiter)"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$text">
        <xsl:element name="token">
          <xsl:value-of select="$text"/>
        </xsl:element>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- TEMPLATE #5: Takes a string with multiple delimiters and creates a nodeset table -->
  <xsl:template name="tokenize-table">
    <xsl:param name="text"/>
    <xsl:param name="delimiter-row"/>
    <xsl:param name="delimiter-col"/>
    <xsl:variable name="rows">
      <xsl:call-template name="tokenize">
        <xsl:with-param name="text" select="$text"/>
        <xsl:with-param name="delimiter" select="$delimiter-row"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:element name="table">
      <xsl:for-each select="exsl:node-set($rows)/token">
        <xsl:variable name="items">
          <xsl:call-template name="tokenize">
            <xsl:with-param name="text" select="text()"/>
            <xsl:with-param name="delimiter" select="$delimiter-col"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:element name="row">
          <xsl:for-each select="exsl:node-set($items)/token">
            <xsl:element name="cell">
              <xsl:value-of select="text()"/>
            </xsl:element>
          </xsl:for-each>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
    
</xsl:stylesheet>