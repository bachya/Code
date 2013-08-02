<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="../f/func-qsort2.xsl"/>
 <xsl:import href="../f/func-map.xsl"/>
 <xsl:import href="../f/func-XpathConstructors.xsl"/>
 <xsl:import href="../f/func-trignm.xsl"/>
 
 <!--  To be applied on ../data/testFunc-qsort2.xml -->
 <xsl:output  omit-xml-declaration="yes" indent="yes"/>
 
 <xsl:variable name="vDoc" select="/"/>
 <xsl:template match="/">
   Integer sort:
==================
<xsl:text/>
   <xsl:for-each select="f:qsort(1 to 10)">
     <xsl:value-of select="."/><xsl:text>&#xA;</xsl:text>
   </xsl:for-each>

String sort:
===================
<xsl:text/>
   <xsl:for-each select="f:qsort(f:map(f:string(), 1 to 10))">
     <xsl:value-of select="."/><xsl:text>&#xA;</xsl:text>
   </xsl:for-each>
=================== 
Date sort  
<xsl:text/>
   <xsl:for-each select="f:qsort(f:map(f:date(), /*/*/*/@dob))">
     <xsl:copy-of select="."/><xsl:text>&#xA;</xsl:text>
   </xsl:for-each>
===================
Date sort:
<xsl:text/>
   <xsl:for-each select="f:qsort(f:map(f:date(), /*/*/*/@dob))">
     <xsl:copy-of select="$vDoc/*/*/*[@dob eq xs:string(current())]"/><xsl:text>&#xA;</xsl:text>
   </xsl:for-each>
   
 </xsl:template>
 
</xsl:stylesheet>