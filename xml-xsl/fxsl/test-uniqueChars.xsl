<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="uniqueChars.xsl" />
  <!-- This transformation must be applied to:
        duplicatedChars.xml 
     -->
  <xsl:output encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:call-template name="uniqueChars">
      <xsl:with-param name="pStr" select="/*/string" />
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
