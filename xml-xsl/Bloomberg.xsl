<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <!-- Template #1 - Identity Transform -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Template #2 - removes the <BloombergOutput> and <Fields> elements -->
  <!-- NOTE: priority="2" ensures that this overrides Template #3, which would also match <Fields> -->
  <xsl:template match="BloombergOutput | Fields" priority="2">
    <xsl:apply-templates />
  </xsl:template>
  
  <!-- Template #3 - for all <Field*> elements, creates a new element with @Name as its name -->
  <xsl:template match="*[starts-with(name(), 'Field')]">
    <xsl:element name="{@Name}">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  
  <!-- Template #4 - by default, pass through the values of all <Value> elements -->
  <xsl:template match="Value">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- Template #5 - overrides Template #4 by correcting number formats for <LastPrice>, <NetChangeOneDay>, and <LastClosePrice> -->
  <xsl:template match="*[contains('| LastPrice | NetChangeOneDay | LastClosePrice |', concat('| ', @Name, ' |'))]/Value">
    <xsl:value-of select="format-number(translate(., '+', ''), '+#0.00;-#0.00')" />
  </xsl:template>
    
</xsl:stylesheet>