<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:IntegralFunction="IntegralFunction"
xmlns:IntegralFunction2="IntegralFunction2"
xmlns:IntegralFunction3="IntegralFunction3"
xmlns:IntegralFunction4="IntegralFunction4"
 exclude-result-prefixes="f IntegralFunction IntegralFunction2
 IntegralFunction3 IntegralFunction4"
>

  <xsl:import href="../f/improvedIntegration.xsl"/>
  
  <!-- To be applied on any source xml.
       Calculates the values for: 
       Integral of x^2 in the interval [0,1] (1/3),
       Integral of x^3 in the interval [0,1] (1/4),
       Integral of 4/(1 + x²)  in the interval [0,1] (Pi),
       Integral of 1/x in the interval [1,2] (ln 2),
       
       with precision 0.0001
    -->

  <xsl:output method="html" encoding="UTF-8"/>

  <IntegralFunction:IntegralFunction/>
  <IntegralFunction2:IntegralFunction2/>
  <IntegralFunction3:IntegralFunction3/>
  <IntegralFunction4:IntegralFunction4/>

  <xsl:template match="/">

    <br />&#xA0;1
    <br /><font size="5">&#x222B;</font> x&#x00B2; =
    <xsl:variable name="vMyFun" select="document('')/*/IntegralFunction:*[1]"/>
    <xsl:call-template name="improvedIntegration">
      <xsl:with-param name="pFun" select="$vMyFun"/>
      <xsl:with-param name="pA" select="0E0"/>
      <xsl:with-param name="pB" select="1E0"/>
      <xsl:with-param name="pEpsRough" select="0.001E0"/>
      <xsl:with-param name="pEpsImproved" select="0.0001E0"/>
    </xsl:call-template>
    <br />0

    <br />
    <br />&#xA0;1
    <br /><font size="5">&#x222B;</font> x&#x00B3; =
    <xsl:variable name="vMyFun2" select="document('')/*/IntegralFunction2:*[1]"/>
    <xsl:call-template name="improvedIntegration">
      <xsl:with-param name="pFun" select="$vMyFun2"/>
      <xsl:with-param name="pA" select="0E0"/>
      <xsl:with-param name="pB" select="1E0"/>
      <xsl:with-param name="pEpsRough" select="0.001E0"/>
      <xsl:with-param name="pEpsImproved" select="0.0001E0"/>
    </xsl:call-template>
    <br />0

    <br />
    <br />&#xA0;1
    <br /><font size="5">&#x222B;</font> 4/(1 + x&#x00B2;) =
    <xsl:variable name="vMyFun3" select="document('')/*/IntegralFunction3:*[1]"/>
    <xsl:call-template name="improvedIntegration">
      <xsl:with-param name="pFun" select="$vMyFun3"/>
      <xsl:with-param name="pA" select="0E0"/>
      <xsl:with-param name="pB" select="1E0"/>
      <xsl:with-param name="pEpsRough" select="0.00001E0"/>
      <xsl:with-param name="pEpsImproved" select="0.0000000000001E0"/>
    </xsl:call-template>
    <br />0

    <br />
    <br />&#xA0;2
    <br /><font size="5">&#x222B;</font> 1/x =
    <xsl:variable name="vMyFun4" select="document('')/*/IntegralFunction4:*[1]"/>
    <xsl:call-template name="improvedIntegration">
      <xsl:with-param name="pFun" select="$vMyFun4"/>
      <xsl:with-param name="pA" select="1E0"/>
      <xsl:with-param name="pB" select="2E0"/>
      <xsl:with-param name="pEpsRough" select="0.00001E0"/>
      <xsl:with-param name="pEpsImproved" select="0.000000001E0"/>
    </xsl:call-template>
    <br />1

  </xsl:template>

  <xsl:template name="myIntegralFn" match="*[namespace-uri()='IntegralFunction']"
   mode="f:FXSL">
    <xsl:param name="pX"/>

    <xsl:value-of select="number($pX) * number($pX)"/>
  </xsl:template>

  <xsl:template name="myIntegralFn2" mode="f:FXSL"
   match="*[namespace-uri()='IntegralFunction2']">
    <xsl:param name="pX"/>

    <xsl:value-of select="number($pX) * number($pX) * number($pX)"/>
  </xsl:template>

  <xsl:template name="myIntegralFn3" mode="f:FXSL"
   match="*[namespace-uri()='IntegralFunction3']">
    <xsl:param name="pX"/>

    <xsl:value-of select="4 div (1 + number($pX) * number($pX))"/>
  </xsl:template>

  <xsl:template name="myIntegralFn4" mode="f:FXSL"
   match="*[namespace-uri()='IntegralFunction4']">
    <xsl:param name="pX"/>

    <xsl:value-of select="1 div number($pX)"/>
  </xsl:template>

</xsl:stylesheet>
