<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:myIsEven="myIsEven"
exclude-result-prefixes="f myIsEven"
>
 
  <xsl:import href="../f/partition.xsl"/>
  
  <!-- To be applied on numList.xml -->
 
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <myIsEven:myIsEven/>
  
  <xsl:template match="/">
    <xsl:variable name="vIsEven" select="document('')/*/myIsEven:*[1]"/>
    
    Partitioning by IsEven:
    <xsl:call-template name="partition">
	    <xsl:with-param name="pList" select="/*/*"/>
	    <xsl:with-param name="pController" select="$vIsEven"/>
    
    </xsl:call-template>
  
  </xsl:template>
  
  <xsl:template name="myIsEven" match="*[namespace-uri()='myIsEven']"
   mode="f:FXSL">
    <xsl:param name="arg1"/>
    
    <xsl:if test="$arg1 mod 2 = 0">1</xsl:if>
  </xsl:template>
</xsl:stylesheet>
