<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:maximum-own-compare="maximum-own-compare"
xmlns:Mycompare="Mycompare"
exclude-result-prefixes="f Mycompare"
>
   <xsl:import href="../f/func-maximum.xsl"/>
   
   <xsl:output omit-xml-declaration="yes"/>
   
   <!-- This transformation must be applied to:
        ../data/numList.xml 

        Expected result: <num>01</num>
	                 <num>10</num>
    -->
   
     <Mycompare:Mycompare/>

    <xsl:template match="/">
<!--
      <xsl:variable name="vCMPFun" select="document('')/*/Mycompare:*[1]"/>

      <xsl:copy-of select="f:maximum(/*/*, $vCMPFun)"/>
      <xsl:text>&#xA;</xsl:text>
-->
      <xsl:copy-of select="f:maximum(/*/*)"/>

    </xsl:template>

    <xsl:template name="MySelectGreater" mode="f:FXSL"
     match="*[namespace-uri() = 'Mycompare']">
         <xsl:param name="arg1"/>
         <xsl:param name="arg2"/>

      <xsl:sequence select="if($arg1 &lt; $arg2)
                              then $arg1
                              else $arg2"/>
    </xsl:template>
</xsl:stylesheet>