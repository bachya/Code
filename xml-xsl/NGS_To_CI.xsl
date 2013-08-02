<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- edited with XML Spy v3.5 NT (http://www.xmlspy.com) by Clyde Craig (Invensys CRM) -->
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
					<propertyKey>
						<xsl:value-of select="PropertyKey"/>
					</propertyKey>
					<propertyName>
						<xsl:value-of select="PropertyName"/>
					</propertyName>
					<eventKey>
						<xsl:value-of select="EventKey"/>
					</eventKey>
					<eventName>
						<xsl:value-of select="EventName"/>
					</eventName>
					<eventPostAs>
						<xsl:value-of select="EventPostAs"/>
					</eventPostAs>
					<groupKey>
						<xsl:value-of select="GroupKey"/>
					</groupKey>
					<groupName>
						<xsl:value-of select="GroupName"/>
					</groupName>
					<startDate>
						<xsl:value-of select="substring(StartDateTime,1,10)"/>
					</startDate>
					<startTime>
						<xsl:value-of select="substring(StartDateTime,12,5)"/>
					</startTime>
					<endDate>
						<xsl:value-of select="substring(EndDateTime,1,10)"/>
					</endDate>
					<endTime>
						<xsl:value-of select="substring(EndDateTime,12,5)"/>
					</endTime>
					<roomKey>
						<xsl:value-of select="RoomKey"/>
					</roomKey>
					<roomName>
						<xsl:value-of select="RoomName"/>
					</roomName>
					<meetingKey>
						<xsl:value-of select="MeetingKey"/>
					</meetingKey>
					<meetingName>
						<xsl:value-of select="MeetingName"/>
					</meetingName>
					<meetingPostAs>
						<xsl:value-of select="MeetingPostAs"/>
					</meetingPostAs>
					<isPostable>
						<xsl:value-of select="IsPostable"/>
					</isPostable>
					<isExhibit>
						<xsl:value-of select="IsExhibit"/>
					</isExhibit>
					<startDateTime>
						<xsl:value-of select="StartDateTime"/>
					</startDateTime>
					<endDateTime>
						<xsl:value-of select="EndDateTime"/>
					</endDateTime>
				</Event>
			</xsl:for-each>
		</Events>
	</xsl:template>
</xsl:stylesheet>
