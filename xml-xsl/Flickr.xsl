<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:flickr="urn:flickr:" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:creativeCommons="http://cyber.law.harvard.edu/rss/creativeCommonsRssModule.html" xmlns:media="http://search.yahoo.com/mrss/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="/*">
  	 <items>
  	 	 <xsl:apply-templates select="channel/item"/>
  	 </items>
  </xsl:template>
  
  <xsl:template match="media:content|media:thumbnail">
  	 <xsl:variable name="vBasename" select="local-name()"/>
  	 <xsl:element name="{concat($vBasename, '_path')}">
  	 	 <xsl:value-of select="@url"/>
  	 </xsl:element>
  	 <xsl:element name="{concat($vBasename, '_height')}">
  	 	 <xsl:value-of select="@height"/>
  	 </xsl:element>
  	 <xsl:element name="{concat($vBasename, '_width')}">
  	 	 <xsl:value-of select="@width"/>
  	 </xsl:element>
  </xsl:template>
  
  <xsl:template match="item/*[not(self::media:content or self::media:thumbnail)]">
  	 <xsl:element name="{local-name()}">
  	 	 <xsl:value-of select="normalize-space()"/>
  	 </xsl:element>
  </xsl:template>
  
  <xsl:template match="item/*[self::dc:date.Taken]">
  	 <dateTaken>
  	 	 <xsl:value-of select="concat(substring-before(., 'T'), ' ', substring-before(substring-after(., 'T'), '-'))"/>
  	 </dateTaken>
  </xsl:template>
  
  <xsl:template match="title|description" priority="2"/>
</xsl:stylesheet>