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
  
  <!-- Remove upper level <Airport> and <Airline> elements - but still process their children -->
  <xsl:template match="Airport | Airline">
    <xsl:apply-templates />
  </xsl:template>
  
  <!-- For <Airports> blocks, concatenate: <Airport> to <Airport> to <Airport>...etc. -->
  <xsl:template match="Airports/Airport">
		<xsl:value-of select="AirportName" />
		<xsl:if test="not(position() = last())"> to </xsl:if>
	</xsl:template>
    
</xsl:stylesheet>