<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
  <xsl:import href="../f/func-getWords.xsl"/>
  <xsl:import href="../f/func-spell.xsl"/>
  
  <xsl:output omit-xml-declaration="yes"/>
 
 <xsl:variable name="vDelim" as="xs:string"> ,—:.-&#9;&#10;&#13;'!?;</xsl:variable>

 <!-- To be applied on ../data/othello.xml --> 
  <xsl:template match="/">
    <xsl:variable name="vwordNodes" as="element()*">
       <xsl:for-each select="//text()/lower-case(.)">
         <xsl:sequence select="f:getWords(., $vDelim, 1)"/>
       </xsl:for-each>
    </xsl:variable>

<!--    
    <xsl:variable name="vUnique" as="xs:string+">
      <xsl:perform-sort select="distinct-values($vwordNodes)">
        <xsl:sort select="."/>
      </xsl:perform-sort>
    </xsl:variable>
-->    
    <xsl:variable name="vnotFound" as="xs:string*">
     <xsl:perform-sort select=
      "distinct-values($vwordNodes[not(f:spell(.))])">
       <xsl:sort select="."/>
     </xsl:perform-sort>
    </xsl:variable>

    <xsl:value-of separator="&#xA;"
     select="$vnotFound"/>
  
    A total of <xsl:value-of select="count($vwordNodes)"/> words 
    were spelt, (<!--<xsl:value-of select="count($vUnique)"/>-->) distinct.
    
    <xsl:value-of select="count($vnotFound)"/> not found.
 </xsl:template>
</xsl:stylesheet>