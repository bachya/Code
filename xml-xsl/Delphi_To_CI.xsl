<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<GetEventsResponse>
			<xsl:apply-templates/>
		</GetEventsResponse>
	</xsl:template>
	<xsl:template match="StatusCode">
		<StatusCode>
			<xsl:value-of select="."/>
		</StatusCode>
	</xsl:template>
	<xsl:template match="StatusDescription">
		<StatusDescription>
			<xsl:value-of select="."/>
		</StatusDescription>
	</xsl:template>
	<xsl:template match="StatusException">
		<StatusException>
			<xsl:value-of select="."/>
		</StatusException>
	</xsl:template>
	<xsl:template match="Events">
		<Events>
			<xsl:for-each select="Event">
				<Event>
					<GroupName>
						<xsl:value-of select="GroupName"/>
					</GroupName>
					<BookingPostAs>
						<xsl:value-of select="EventPostAs"/>
					</BookingPostAs>
					<Name>
						<xsl:value-of select="MeetingPostAs"/>
					</Name>
					<FunctionRoomNumber>
						<xsl:value-of select="RoomKey"/>
					</FunctionRoomNumber>
					<FunctionRoomAbbrev>
						<xsl:value-of select="RoomKey"/>
					</FunctionRoomAbbrev>
					<FunctionRoomName>
						<xsl:value-of select="RoomName"/>
					</FunctionRoomName>
					<StartTime>
						<xsl:value-of select="substring(StartDateTime,12,5)"/>
					</StartTime>
					<EndTime>
						<xsl:value-of select="substring(EndDateTime,12,5)"/>
					</EndTime>
					<EventType>
						<xsl:value-of select="MeetingName"/>
					</EventType>
					<EventTypeAbbrev>
						<xsl:value-of select="MeetingKey"/>
					</EventTypeAbbrev>
					<AgreedAttendance>
						<xsl:value-of select="AgreedAttendance"/>
					</AgreedAttendance>
					<StartDateTime>
						<xsl:value-of select="StartDateTime"/>
					</StartDateTime>
					<EndDateTime>
						<xsl:value-of select="EndDateTime"/>
					</EndDateTime>
					<Post>
						<xsl:value-of select="IsPostable"/>
					</Post>
				</Event>
			</xsl:for-each>
		</Events>
	</xsl:template>
</xsl:stylesheet>
