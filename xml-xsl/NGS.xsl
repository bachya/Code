<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:myutils="http://mycoolplace.com">
  <xsl:output method="xml" version="1.0" encoding="UTF-8"
  indent="no" omit-xml-declaration="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <Events>
      <xsl:apply-templates select="*" />
    </Events>
  </xsl:template>
  <xsl:template match="*[name() = 'MeetingSpace']">
    <Event>
      <xsl:element name="propertyKey">
        <xsl:value-of select="../../@propertyKey" />
      </xsl:element>
      <xsl:element name="propertyName">
        <xsl:value-of select="../../@propertyName" />
      </xsl:element>
      <xsl:element name="eventKey">
        <xsl:value-of select="../@eventKey" />
      </xsl:element>
      <xsl:element name="eventName">
        <xsl:value-of select="../@eventName" />
      </xsl:element>
      <xsl:element name="eventPostAs">
        <xsl:value-of select="../@eventPostAs" />
      </xsl:element>
      <xsl:for-each select="preceding-sibling::*">
        <xsl:if test="name() = 'Group'">
          <xsl:element name="groupKey">
            <xsl:value-of select="@key" />
          </xsl:element>
          <xsl:element name="groupName">
            <xsl:value-of select="@name" />
          </xsl:element>
        </xsl:if>
      </xsl:for-each>
      <xsl:element name="startDateTime">
        <xsl:value-of select="concat(substring-before(@startDateTime, 'T'), ' ', substring-after(@startDateTime, 'T'))" />
      </xsl:element>
      <xsl:element name="startDate">
        <xsl:value-of select="substring(@startDateTime,1,10)" />
      </xsl:element>
      <xsl:element name="startTime">
        <xsl:value-of select="substring(@startDateTime,12,5)" />
      </xsl:element>
      <xsl:element name="endDateTime">
        <xsl:value-of select="concat(substring-before(@endDateTime, 'T'), ' ', substring-after(@endDateTime, 'T'))" />
      </xsl:element>
      <xsl:element name="endDate">
        <xsl:value-of select="substring(@endDateTime,1,10)" />
      </xsl:element>
      <xsl:element name="endTime">
        <xsl:value-of select="substring(@endDateTime,12,5)" />
      </xsl:element>
      <xsl:element name="roomKey">
        <xsl:value-of select="@roomKey" />
      </xsl:element>
      <xsl:element name="roomName">
        <xsl:value-of select="@roomName" />
      </xsl:element>
      <xsl:element name="meetingKey">
        <xsl:value-of select="@meetingKey" />
      </xsl:element>
      <xsl:element name="meetingName">
        <xsl:value-of select="@meetingName" />
      </xsl:element>
      <xsl:element name="meetingPostAs">
        <xsl:value-of select="@meetingPostAs" />
      </xsl:element>
      <xsl:element name="isPostable">
        <xsl:value-of select="@isPostable" />
      </xsl:element>
      <xsl:element name="isExhibit">
        <xsl:value-of select="@isExhibit" />
      </xsl:element>
    </Event>
    <xsl:apply-templates select="*" />
  </xsl:template>
  <xsl:template match="*[name() = 'SubMeeting']">
    <Event>
      <xsl:element name="propertyKey">
        <xsl:value-of select="../../../@propertyKey" />
      </xsl:element>
      <xsl:element name="propertyName">
        <xsl:value-of select="../../../@propertyName" />
      </xsl:element>
      <xsl:element name="eventKey">
        <xsl:value-of select="../../@eventKey" />
      </xsl:element>
      <xsl:element name="eventName">
        <xsl:value-of select="../../@eventName" />
      </xsl:element>
      <xsl:element name="eventPostAs">
        <xsl:value-of select="../../@eventPostAs" />
      </xsl:element>
      <xsl:for-each select="../preceding-sibling::*">
        <xsl:if test="name() = 'Group'">
          <xsl:element name="groupKey">
            <xsl:value-of select="@key" />
          </xsl:element>
          <xsl:element name="groupName">
            <xsl:value-of select="@name" />
          </xsl:element>
        </xsl:if>
      </xsl:for-each>
      <xsl:element name="startDate">
        <xsl:value-of select="substring(@startDateTime,1,10)" />
      </xsl:element>
      <xsl:element name="startTime">
        <xsl:value-of select="substring(@startDateTime,12,5)" />
      </xsl:element>
      <xsl:element name="endDate">
        <xsl:value-of select="substring(@endDateTime,1,10)" />
      </xsl:element>
      <xsl:element name="endTime">
        <xsl:value-of select="substring(@endDateTime,12,5)" />
      </xsl:element>
      <xsl:element name="roomKey">
        <xsl:value-of select="../@roomKey" />
      </xsl:element>
      <xsl:element name="roomName">
        <xsl:value-of select="../@roomName" />
      </xsl:element>
      <xsl:element name="meetingKey">
        <xsl:value-of select="@subMeetingKey" />
      </xsl:element>
      <xsl:element name="meetingName">
        <xsl:value-of select="@subMeetingName" />
      </xsl:element>
      <xsl:element name="meetingPostAs">
        <xsl:value-of select="@meetingPostAs" />
      </xsl:element>
      <xsl:element name="isPostable">
        <xsl:value-of select="@isPostable" />
      </xsl:element>
      <xsl:element name="isExhibit">
        <xsl:value-of select="../@isExhibit" />
      </xsl:element>
    </Event>
  </xsl:template>
</xsl:stylesheet>
