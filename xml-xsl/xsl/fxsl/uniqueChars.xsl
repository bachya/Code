<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:uniqueChars="f:uniqueChars" version="1.0">
  <xsl:import href="str-foldl.xsl" />
  <xsl:output omit-xml-declaration="yes" indent="yes" />
  <xsl:strip-space elements="*" />
  <uniqueChars:uniqueChars />
  <xsl:variable name="vFuncUniqueChars"
  select="document('')/*/uniqueChars:*[1]" />
  <xsl:template name="uniqueChars">
    <xsl:param name="pStr" select="/.." />
    <xsl:call-template name="str-foldl">
      <xsl:with-param name="pFunc" select="$vFuncUniqueChars" />
      <xsl:with-param name="pA0" select="''" />
      <xsl:with-param name="pStr" select="$pStr" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="uniqueChars:*">
    <xsl:param name="arg1" />
    <xsl:param name="arg2" />
    <xsl:value-of select="$arg1" />
    <xsl:if test="not(contains($arg1, $arg2))">
      <xsl:value-of select="$arg2" />
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
