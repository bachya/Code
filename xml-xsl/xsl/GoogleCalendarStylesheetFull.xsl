<?xml version="1.0"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:f="http://www.w3.org/2005/Atom"
  xmlns:gd="http://schemas.google.com/g/2005"
  version="1.0">
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
	<!-- Main Template -->
	<xsl:template match="/">
		<Events>
			<xsl:apply-templates select="//f:entry" />
		</Events>
	</xsl:template>
	<!-- Dynamic Templates -->
	<xsl:template match="f:entry">
		<xsl:variable name="startDateTime" select="gd:when/@startTime" />
		<xsl:variable name="startDate" select="substring($startDateTime, 0, 11)" />
		<xsl:variable name="startTime" select="substring-before(substring-after($startDateTime, 'T'), '.')" />
		<xsl:variable name="endDateTime" select="gd:when/@endTime" />
		<xsl:variable name="endDate" select="substring($endDateTime, 0, 11)" />
		<xsl:variable name="endTime" select="substring-before(substring-after($endDateTime, 'T'), '.')" />
		<Event>
			<EventTitle>
				<xsl:value-of select="f:title[1]" />
			</EventTitle>
			<StartDateTime>
				<xsl:choose>
					<xsl:when test="$startTime = ''">
						<xsl:value-of select="concat($startDate, ' 00:00:00')" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($startDate, ' ', $startTime)" />
					</xsl:otherwise>
				</xsl:choose>
			</StartDateTime>
			<EndDateTime>
				<xsl:choose>
					<xsl:when test="$endTime = ''">
						<xsl:value-of select="concat($endDate, ' 23:59:59')" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($endDate, ' ', $endTime)" />
					</xsl:otherwise>
				</xsl:choose>
			</EndDateTime>
			<Who>
				<xsl:value-of select="f:author/f:name" />
			</Who>
			<Where>
				<xsl:value-of select="gd:where/@valueString" />
			</Where>
			<Status>
				<xsl:value-of select="gd:eventStatus/@value" />
			</Status>
		</Event>
	</xsl:template>
</xsl:stylesheet>