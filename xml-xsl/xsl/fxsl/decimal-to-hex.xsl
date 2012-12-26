<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:dec-to-hex="dec-to-hex" exclude-result-prefixes="dec-to-hex"
version="1.0">
  <xsl:import href="str-foldl.xsl" />
  <dec-to-hex:dec-to-hex />
  <xsl:variable name="vFuncDecToHex"
  select="document('')/*/dec-to-hex:*[1]" />
  <xsl:variable name="hexDigits" select="'0123456789ABCDEF'" />
  <!-- <xsl:template name="decimal-to-hex"> -->
  <xsl:template match="/">
    <!-- <xsl:param name="pxNumber" -->
    <xsl:call-template name="str-foldl">
      <xsl:with-param name="pFunc" select="$vFuncDecToHex" />
      <xsl:with-param name="pA0" select="0" />
      <xsl:with-param name="pStr" select="1007" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="toHex">
    <xsl:param name="decimalNumber" />
    <xsl:if test="$decimalNumber &gt;= 16">
      <xsl:call-template name="toHex">
        <xsl:with-param name="decimalNumber"
        select="floor($decimalNumber div 16)" />
      </xsl:call-template>
    </xsl:if>
    <xsl:value-of select="substring($hexDigits, ($decimalNumber mod 16) + 1, 1)" />
  </xsl:template>
  <xsl:template name="dec-to-hex" match="dec-to-hex:*">
    <xsl:param name="arg1" select="0" />
    <!-- $pA0 -->
    <xsl:call-template name="toHex">
      <xsl:with-param name="decimalNumber" select="$arg1" />
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
