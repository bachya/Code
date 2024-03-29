<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:IntegralFunction="IntegralFunction"
xmlns:IntegralFunction2="IntegralFunction2"
xmlns:IntegralFunction3="IntegralFunction3"
xmlns:IntegralFunction4="IntegralFunction4"
exclude-result-prefixes="xsl IntegralFunction IntegralFunction2 IntegralFunction3 IntegralFunction4">

  <xsl:import href="improvedIntegration.xsl" />
  <xsl:output indent="yes" omit-xml-declaration="yes" />
  <IntegralFunction:IntegralFunction />
  <IntegralFunction2:IntegralFunction2 />
  <IntegralFunction3:IntegralFunction3 />
  <IntegralFunction4:IntegralFunction4 />
  <xsl:template match="/">
    <xsl:text>

</xsl:text>
    <xsl:variable name="vMyFun4"
    select="document('')/*/IntegralFunction4:*[1]" />
    <xsl:call-template name="improvedIntegration">
      <xsl:with-param name="pFun" select="$vMyFun4" />
      <xsl:with-param name="pA" select="1" />
      <xsl:with-param name="pB" select="2" />
      <xsl:with-param name="pEpsRough" select="0.001" />
      <xsl:with-param name="pEpsImproved" select="0.01" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="myIntegralFn"
  match="*[namespace-uri()='IntegralFunction']">
    <xsl:param name="pX" />
    <xsl:value-of select="$pX * $pX" />
  </xsl:template>
  <xsl:template name="myIntegralFn2"
  match="*[namespace-uri()='IntegralFunction2']">
    <xsl:param name="pX" />
    <xsl:value-of select="$pX * $pX * $pX" />
  </xsl:template>
  <xsl:template name="myIntegralFn3"
  match="*[namespace-uri()='IntegralFunction3']">
    <xsl:param name="pX" />
    <xsl:value-of select="4 div (1 + $pX * $pX)" />
  </xsl:template>
  <xsl:template name="myIntegralFn4"
  match="*[namespace-uri()='IntegralFunction4']">
    <xsl:param name="pX" />
    <xsl:value-of select="1 div $pX" />
  </xsl:template>
</xsl:stylesheet>
