<?xml version="1.0" encoding="UTF-8"?>

<!--
Copyright © 2013 George Anastassakis (anastas@unipi.gr)

This file is part of cvxmltools.

cvxmltools is free software: you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

cvxmltools is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
cvxmltools. If not, see http://www.gnu.org/licenses/.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

<xsl:output method="xml" indent="yes"/>

<xsl:strip-space elements="*" />

<xsl:param name="version" />
<xsl:param name="lang" />

<!-- Required preprocessing -->
<xsl:template match="/">
  <xsl:choose>
    <xsl:when test="$version!='' and $lang!=''">
      <xsl:apply-templates />
    </xsl:when>
    <xsl:otherwise>
      <xsl:message terminate="yes">ERROR: Both the "version" and "lang" parameters must be specified!</xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- General-purpose deep-copy template -->
<xsl:template match="@*|node()[not(self::comment())]">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()" />
  </xsl:copy>
</xsl:template>

<!-- Template for top-level "cv" node -->
<xsl:template match="/cv">
  <cv>
	<xsl:attribute name="xsi:noNamespaceSchemaLocation">CVXMLTools-flat.xsd</xsl:attribute>
	<xsl:attribute name="date"><xsl:value-of select="@date" /></xsl:attribute>
    <xsl:attribute name="version"><xsl:value-of select="$version" /></xsl:attribute>
    <xsl:attribute name="lang"><xsl:value-of select="$lang" /></xsl:attribute>
    <xsl:apply-templates />
  </cv>
</xsl:template>

<!-- Elements with a "version" attribute -->
<xsl:template match="*[@version]">
  <xsl:if test="@version=$version">
    <xsl:element name="{name()}">
      <xsl:for-each select="@*">
        <xsl:if test="name()!='version'">
          <xsl:apply-templates select="." />
        </xsl:if>
      </xsl:for-each>
      <xsl:apply-templates select="node()" />
    </xsl:element>
  </xsl:if>
</xsl:template>

<!-- "Value" elements with a "lang" attribute -->
<xsl:template match="value[@lang]">
  <xsl:if test="@lang=$lang">
    <xsl:value-of select="." />
  </xsl:if>
</xsl:template>

<!-- "Value" elements without a "lang" attribute -->
<xsl:template match="value[not(@lang)]">
  <xsl:value-of select="." />
</xsl:template>

</xsl:stylesheet>
