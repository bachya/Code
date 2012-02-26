<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>
  
  <xsl:key name="kContractByContractNo" match="ContractInfo" use="@ContractNo" />
  <xsl:key name="kFiledataByContractNo" match="Filedata" use="../../@ContractNo" />

  <!-- Template #1 - Identity Transform -->
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="ContractInfo">
    <xsl:if test="generate-id() = generate-id(key('kContractByContractNo', @ContractNo)[1])">
      <xsl:copy>
        <xsl:apply-templates select="key('kContractByContractNo', @ContractNo)/Details | @*" />
      </xsl:copy>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="Details">
    <xsl:if test="generate-id(..) = generate-id(key('kContractByContractNo', ../@ContractNo)[1])">
      <xsl:copy>
        <xsl:apply-templates select="key('kFiledataByContractNo', ../@ContractNo) | @*" />
      </xsl:copy>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>