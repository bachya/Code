<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output omit-xml-declaration="no" indent="yes" />
  <xsl:strip-space elements="*" />

  <xsl:variable name="vNumberOfTimeNodes" select="'6'" />

  <xsl:variable name="vRandomNodes" select="/|//node()|//@*|//namespace::*" />

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="times" />

  <xsl:template match="/*">
    <movies>
      <xsl:apply-templates select="*/*/movie">
        <xsl:with-param name="pCinemaName" select="@name" />
      </xsl:apply-templates>
    </movies>
  </xsl:template>

  <xsl:template match="icons">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="movie">
    <xsl:param name="pCinemaName" />
    <xsl:variable name="vMovie" select="." />
    <movie>
      <xsl:apply-templates select="@*|node()" />
      <cinema_name>
        <xsl:value-of select="$pCinemaName" />
      </cinema_name>
      <xsl:apply-templates select="current()/ancestor::cinema/@*" />
      <xsl:for-each select="$vRandomNodes[position() &lt;= $vNumberOfTimeNodes]">
        <xsl:variable name="vPos" select="position()" />
        <xsl:element name="{concat('time_', position())}">
          <xsl:value-of select="$vMovie/times/*[$vPos]" />
        </xsl:element>
        <xsl:element name="{concat('available_', position())}">
          <xsl:value-of select="$vMovie/times/*[$vPos]/@available" />
        </xsl:element>
        <xsl:element name="{concat('sold_', position())}">
          <xsl:value-of select="$vMovie/times/*[$vPos]/@sold" />
        </xsl:element>
      </xsl:for-each>
    </movie>
  </xsl:template>
  
  <xsl:template match="cinema/@*">
    <xsl:element name="{concat(name(..), '_', name())}">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
