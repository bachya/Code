<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:media="http://search.yahoo.com/mrss/"
>
	<!-- Main Template -->
	<xsl:template match="/">
		<Photos>
			<xsl:apply-templates select="//*[local-name() = 'item']" />
		</Photos>
	</xsl:template>
	<!-- Dynamic Templates -->
	<xsl:template match="item">
		<Photo>
			<Title>
				<xsl:value-of select="title" />
			</Title>
			<Author>
				<xsl:value-of select="media:group/media:credit" />
			</Author>
			<ImagePath>
				<xsl:value-of select="media:group/media:content/@url" />
			</ImagePath>
			<ThumbnailPath>
				<xsl:value-of select="media:group/media:thumbnail/@url" />
			</ThumbnailPath>
			<PublishDate>
				<xsl:value-of select="pubDate" />
			</PublishDate>
		</Photo>
	</xsl:template>
</xsl:stylesheet>