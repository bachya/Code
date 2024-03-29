<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:IntegralFunction="IntegralFunction"
xmlns:IntegralFunction2="IntegralFunction2"
xmlns:IntegralFunction3="IntegralFunction3"
xmlns:IntegralFunction4="IntegralFunction4"
exclude-result-prefixes="xsl IntegralFunction IntegralFunction2 IntegralFunction3 IntegralFunction4">

  <xsl:import href="simpleIntegration.xsl" />
  <!-- <xsl:output method="html" encoding="UTF-8"/> -->
  <IntegralFunction:IntegralFunction />
  <IntegralFunction2:IntegralFunction2 />
  <IntegralFunction3:IntegralFunction3 />
  <IntegralFunction4:IntegralFunction4 />
  <xsl:template match="/">
  <br />1 
  <br />&#8747; x&#178; = 
  <xsl:variable name="vMyFun"
  select="document('')/*/IntegralFunction:*[1]" />
  <xsl:call-template name="simpleIntegration">
    <xsl:with-param name="pFun" select="$vMyFun" />
    <xsl:with-param name="pA" select="0" />
    <xsl:with-param name="pB" select="1" />
    <xsl:with-param name="pEpsRough" select="0.001" />
  </xsl:call-template>
  <br />0 
  <br />
  <br />1 
  <br />&#8747; x&#179; = 
  <xsl:variable name="vMyFun2"
  select="document('')/*/IntegralFunction2:*[1]" />
  <xsl:call-template name="simpleIntegration">
    <xsl:with-param name="pFun" select="$vMyFun2" />
    <xsl:with-param name="pA" select="0" />
    <xsl:with-param name="pB" select="1" />
    <xsl:with-param name="pEpsRough" select="0.0001" />
  </xsl:call-template>
  <br />0 
  <br />
  <br />1 
  <br />&#8747; 4/(1 + x&#178;) = 
  <xsl:variable name="vMyFun3"
  select="document('')/*/IntegralFunction3:*[1]" />
  <xsl:call-template name="simpleIntegration">
    <xsl:with-param name="pFun" select="$vMyFun3" />
    <xsl:with-param name="pA" select="0" />
    <xsl:with-param name="pB" select="1" />
    <xsl:with-param name="pEpsRough" select="0.0001" />
  </xsl:call-template>
  <br />0 
  <br />
  <br />2 
  <br />&#8747; 1/x = 
  <xsl:variable name="vMyFun4"
  select="document('')/*/IntegralFunction4:*[1]" />
  <xsl:call-template name="simpleIntegration">
    <xsl:with-param name="pFun" select="$vMyFun4" />
    <xsl:with-param name="pA" select="1" />
    <xsl:with-param name="pB" select="2" />
    <xsl:with-param name="pEpsRough" select="0.0001" />
  </xsl:call-template>
  <br />1</xsl:template>
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
