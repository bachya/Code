<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:myFun="f:myFun" xmlns:myFunPrim="f:myFunPrim"
exclude-result-prefixes="xsl myFun myFunPrim">
  <xsl:import href="findRoot.xsl" />
  <xsl:import href="trignm.xsl" />
  <xsl:output method="text" />
  <myFun:myFun />
  <myFunPrim:myFunPrim />
  <xsl:template match="/">
    <xsl:call-template name="findRootNR">
      <xsl:with-param name="pFun"
      select="document('')/*/myFun:*[1]" />
      <xsl:with-param name="pFunPrim"
      select="document('')/*/myFunPrim:*[1]" />
      <xsl:with-param name="pX0" select="$pi div 4" />
      <xsl:with-param name="pEps" select="0.0000001" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="myFun:*">
    <xsl:param name="arg1" />
    <xsl:variable name="vSineX">
      <xsl:call-template name="sin">
        <xsl:with-param name="pX" select="$arg1" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="$vSineX - 0.5" />
  </xsl:template>
  <xsl:template match="myFunPrim:*">
    <xsl:param name="arg1" />
    <xsl:call-template name="cos">
      <xsl:with-param name="pX" select="$arg1" />
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
