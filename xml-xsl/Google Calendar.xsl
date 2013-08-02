<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:gd="http://schemas.google.com/g/2005" xmlns:a="http://www.w3.org/2005/Atom" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="a gd" version="1.0">
  <xsl:output omit-xml-declaration="no" indent="yes"/>
  <xsl:strip-space elements="*"/>
  
  <xsl:template match="/*">
    <Events>
      <xsl:apply-templates select="a:entry"/>
    </Events>
  </xsl:template>
  
  <xsl:template match="a:entry">
    <Event>
      <xsl:apply-templates select="a:title|a:content|a:author/a:name|gd:where|gd:when|gd:eventStatus"/>
    </Event>
  </xsl:template>
  
  <xsl:template match="a:title">
    <Title>
      <xsl:apply-templates/>
    </Title>
  </xsl:template>
  
  <xsl:template match="a:content">
    <Description>
      <xsl:apply-templates/>
    </Description>
  </xsl:template>
  
  <xsl:template match="a:name">
    <Who>
      <xsl:apply-templates/>
    </Who>
  </xsl:template>
  
  <xsl:template match="gd:where">
    <Where>
      <xsl:value-of select="@valueString"/>
    </Where>
  </xsl:template>
  
  <xsl:template match="gd:when">
    <StartDateTime>
      <xsl:value-of select="concat(substring-before(@startTime, 'T'), ' ', substring-after(substring-before(@startTime, '.'), 'T'))"/>
    </StartDateTime>
    <EndDateTime>
      <xsl:value-of select="concat(substring-before(@endTime, 'T'), ' ', substring-after(substring-before(@endTime, '.'), 'T'))"/>
    </EndDateTime>
  </xsl:template>
  
  <xsl:template match="gd:eventStatus">
    <Status>
      <xsl:value-of select="@value"/>
    </Status>
  </xsl:template>
</xsl:stylesheet>
