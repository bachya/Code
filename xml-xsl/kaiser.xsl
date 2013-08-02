<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
  <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <!-- Key to match <item> elements by the number in the <description> element (e.g., "1" in "room: 1") -->
  <xsl:key name="kItemsByRoomID" match="item" use="substring-after(substring-before(description, ','), ' ')" />

  <!-- Identity Template - by default, copy all nodes/attributes as-is -->
  <xsl:template match="node()|@*">
      <xsl:copy>
          <xsl:apply-templates select="node()|@*"/>
      </xsl:copy>
  </xsl:template>
  
  <!-- Since the feed is output in chronological order, grab the last <item> per unique numeric key (defined by kItemsByRoomID) -->
  <!-- and output it; make sure the sorting is based on <title>, which carries the date/time -->
  <xsl:template match="channel">
    <xsl:copy>
      <xsl:for-each select="item[generate-id()=generate-id(key('kItemsByRoomID', substring-after(substring-before(description, ','), ' '))[last()])]">
        <xsl:sort order="descending" select="concat(
          substring-after(substring-after(substring-before(title, ' '), '/'), '/'),
          substring-before(title, '/'),
          substring-before(substring-after(substring-before(title, ' '), '/'), '/'),
          '-',
          substring-after(title, ' ')
          )" />        
        <xsl:copy>
          <xsl:apply-templates />
        </xsl:copy>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
    
</xsl:stylesheet>