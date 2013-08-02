<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/" xmlns:ext="http://exslt.org/common"
xmlns:test-map-product="test-map-product"
xmlns:salesSumProduct="salesSumProduct"
exclude-result-prefixes="xsl f ext test-map-product salesSumProduct">

  <xsl:import href="sum.xsl" />
  <xsl:import href="map.xsl" />
  <xsl:import href="product.xsl" />
  <xsl:output method="text" />
  <salesSumProduct:salesSumProduct />
  <xsl:variable name="vFuncSalesSumProduct"
  select="document('')/*/salesSumProduct:*[1]" />
  <xsl:template match="/">
    <xsl:variable name="vSalesTotals">
      <xsl:call-template name="map">
        <xsl:with-param name="pFun"
        select="$vFuncSalesSumProduct" />
        <xsl:with-param name="pList1" select="/sales/sale" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="sum">
      <xsl:with-param name="pList"
      select="ext:node-set($vSalesTotals)/*" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="salesSumProduct:*">
    <xsl:param name="arg1" />
    <xsl:call-template name="product">
      <xsl:with-param name="pList" select="$arg1/*" />
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
