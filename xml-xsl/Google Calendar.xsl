<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:gd="http://schemas.google.com/g/2005"
  xmlns:a="http://www.w3.org/2005/Atom"
  exclude-result-prefixes="a gd"
  version="1.0">
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
    <xsl:variable name="startDateTime" select="@startTime"/>
    <xsl:variable name="startDate" select="substring($startDateTime, 0, 11)"/>
    <xsl:variable name="startTime" select="substring-before(substring-after($startDateTime, 'T'), '.')"/>
    <xsl:variable name="endDateTime" select="@endTime"/>
    <xsl:variable name="endDate" select="substring($endDateTime, 0, 11)"/>
    <xsl:variable name="endTime" select="substring-before(substring-after($endDateTime, 'T'), '.')"/>

    <StartDateTime>
      <xsl:choose>
        <xsl:when test="$startTime = ''">
          <xsl:value-of select="concat($startDate, ' 00:00:00')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat($startDate, ' ', $startTime)"/>
        </xsl:otherwise>
      </xsl:choose>
    </StartDateTime>

    <EndDateTime>
      <xsl:choose>
        <xsl:when test="$endTime = ''">
          <xsl:value-of select="concat($endDate, ' 23:59:59')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat($endDate, ' ', $endTime)"/>
        </xsl:otherwise>
      </xsl:choose>
    </EndDateTime>
  </xsl:template>

  <xsl:template match="gd:eventStatus">
    <Status>
      <xsl:value-of select="@value"/>
    </Status>
  </xsl:template>

</xsl:stylesheet>

