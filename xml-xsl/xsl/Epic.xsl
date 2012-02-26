<?xml version="1.0"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:h="http://www.opentravel.org/2006A"
  version="1.0">
	<!-- Main Template -->
	<xsl:template match="/">
		<Hotels>
			<xsl:apply-templates select="//h:HotelDescriptiveContent"/>
		</Hotels>
	</xsl:template>
	<!-- Dynamic Templates -->
	<xsl:template match="h:HotelDescriptiveContent">
		<Hotel>
			<HotelCode>
				<xsl:value-of select="@HotelCode" />
			</HotelCode>
			<HotelName>
				<xsl:value-of select="@HotelName" />
			</HotelName>
			<Latitude>
				<xsl:value-of select="h:HotelInfo/h:Position/@Latitude" />
			</Latitude>
			<Longitude>
				<xsl:value-of select="h:HotelInfo/h:Position/@Longitude" />
			</Longitude>
			<xsl:apply-templates select="h:HotelInfo/h:Descriptions/h:Description"/>
			<Services>
				<xsl:apply-templates select="h:HotelInfo/h:Services/h:Service"/>
			</Services>
			<Restaurants>
				<xsl:apply-templates select="h:FacilityInfo/h:Restaurants/h:Restaurant"/>
			</Restaurants>
		</Hotel>
	</xsl:template>
	<xsl:template match="h:Description">
		<xsl:variable name="fieldName" select="translate(@Name,' /','')" />
		<xsl:element name="{$fieldName}">
			<xsl:value-of select="h:Text" />
		</xsl:element>
	</xsl:template>
	<xsl:template match="h:Service">
		<Service>
		</Service>
	</xsl:template>
	<xsl:template match="h:Restaurant">
		<Restaurant>
			<Name>
				<xsl:value-of select="@RestaurantName" />
			</Name>
			<xsl:apply-templates select="h:RestaurantDescription"/>
		</Restaurant>
	</xsl:template>
	<xsl:template match="h:RestaurantDescription">
		<xsl:variable name="fieldName" select="translate(@Name,' /','')" />
		<xsl:element name="{$fieldName}">
			<xsl:value-of select="h:Text" />
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>