<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:z="#RowsetSchema" xmlns:rs="urn:schemas-microsoft-com:rowset" xmlns:s="uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <!-- Identity Template: copies everything as-is -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  <!-- We don't need the <s:Schema> element or any of its children, -->
  <!-- so get rid of it -->
  <xsl:template match="s:Schema"/>
  <!-- Get rid of the rs namespace on <rs:data> -->
  <xsl:template match="rs:data">
    <xsl:element name="{local-name(.)}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <!-- For each <z:row>, create a new <event> element and process -->
  <!-- its attributes -->
  <xsl:template match="z:row">
    <event>
      <xsl:apply-templates select="@*"/>
    </event>
  </xsl:template>
  <!-- Turn attributes of <z:row> into child elements -->
  <xsl:template match="z:row/@*">
    <xsl:element name="{name(.)}">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>