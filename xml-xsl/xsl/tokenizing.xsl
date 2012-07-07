<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="exsl" version="1.0">
  <xsl:output omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="Employees">
    <xsl:variable name="vNames">
      <xsl:call-template name="tokenize">
        <xsl:with-param name="text" select="Names/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="vLocations">
      <xsl:call-template name="tokenize">
        <xsl:with-param name="text" select="Location/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:apply-templates select="exsl:node-set($vNames)/token">
      <xsl:with-param name="pLocation" select="exsl:node-set($vLocations)/token"/>
      <xsl:with-param name="pWeather" select="Weather"/>
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="token">
    <xsl:param name="pLocation"/>
    <xsl:param name="pWeather"/>
    <xsl:variable name="vPosition" select="position()"/>
    <Employees>
      <Names>
        <xsl:value-of select="."/>
      </Names>
      <Location>
        <xsl:value-of select="translate($pLocation[$vPosition],              'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
      </Location>
      <xsl:choose>
        <xsl:when test="$pWeather != ''">
          <xsl:apply-templates select="$pWeather"/>
        </xsl:when>
        <xsl:otherwise>
          <Weather>100%</Weather>
        </xsl:otherwise>
      </xsl:choose>
    </Employees>
  </xsl:template>
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
</xsl:stylesheet>