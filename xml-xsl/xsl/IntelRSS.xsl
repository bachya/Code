<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0">
  <!-- Main Template -->
  <xsl:template match="/">
    <items>
      <xsl:apply-templates select="//*[local-name() = 'item']" />
    </items>
  </xsl:template>
  <!-- Dynamic Templates -->
  <xsl:template match="item">
    <item>
      <category>
        <xsl:value-of select="category" />
      </category>
      <pubDate>
        <xsl:value-of select="pubDate" />
      </pubDate>
      <location>
        <xsl:value-of select="location']" />
      </location>
      <image>
        <xsl:value-of select="digital_signage/image" />
      </image>
      <headline>
        <xsl:value-of select="digital_signage/body/headline" />
      </headline>
      <opening>
        <xsl:value-of select="digital_signage/body/opening" />
      </opening>
      <boldsentence>
        <xsl:value-of select="digital_signage/body/boldsentence" />
      </boldsentence>
      <bullet1>
        <xsl:value-of select="digital_signage/body/bullet1" />
      </bullet1>
      <bullet2>
        <xsl:value-of select="digital_signage/body/bullet2" />
      </bullet2>
      <bullet3>
        <xsl:value-of select="digital_signage/body/bullet3" />
      </bullet3>
      <finalsentence>
        <xsl:value-of select="digital_signage/body/finalsentence" />
      </finalsentence>
    </item>
  </xsl:template>
</xsl:stylesheet>