<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
   <xsl:import href="../f/func-transform-and-sum.xsl"/>
   <xsl:import href="../f/func-standardXpathFunctions.xsl"/>

   <!-- to be applied on numList.xml -->

   <xsl:output method="text"/>
   
    <xsl:template match="/">
      <xsl:value-of select=
      "f:transform-and-sum(f:string-length(), /*/*)"/>
    </xsl:template>
</xsl:stylesheet>