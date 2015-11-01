<?xml version="1.0" encoding="UTF-8"?>

<!--
Copyright © 2013-2015 George Anastassakis (anastas@unipi.gr)

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

<!-- TODO: Obviously, standard sections require a per-language title as well.
Bleh. -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" />

<xsl:template name="formattedfullname"><xsl:value-of select="firstname" /><xsl:text> </xsl:text><xsl:value-of select="lastname" /></xsl:template>

<xsl:template name="formattedemail"><xsl:value-of select="text()" /></xsl:template>

<xsl:template name="formattedtelephone"><xsl:value-of select="text()" /></xsl:template>

<xsl:template name="formattedhomepage"><xsl:value-of select="text()" /></xsl:template>

<xsl:template name="formatteddegreetitle"><xsl:value-of select="title" />, <xsl:value-of select="institution" />, <xsl:value-of select="country" />, <xsl:value-of select="date" /></xsl:template>

<xsl:template name="formatteddegreenote">. <xsl:value-of select="note" /></xsl:template>

<xsl:template name="formattedlanguagetitle"><xsl:value-of select="title" />, <xsl:value-of select="degree" /></xsl:template>

<xsl:template name="formattedlanguagenote">. <xsl:value-of select="note" /></xsl:template>

<xsl:template name="periodifneeded"><xsl:if test="substring(data, string-length(data), 1)!='.'">.</xsl:if></xsl:template>

<xsl:template match="/">
<xsl:apply-templates />
</xsl:template>

<xsl:template match="/cv">

<html>

	<head>
		<title><xsl:value-of select="data/name/firstname" /><xsl:text> </xsl:text><xsl:value-of select="data/name/lastname" /> - Curriculum Vitae</title>
		<meta charset="UTF-8"></meta>
	</head>

	<body>

		<h1><xsl:value-of select="data/name/firstname" /><xsl:text> </xsl:text><xsl:value-of select="data/name/lastname" /></h1>
		<h1>Curriculum Vitae</h1>
		<h1><xsl:value-of select="@date" /></h1>

		<xsl:apply-templates select="data" />
		<xsl:apply-templates select="education" />
		<xsl:apply-templates select="languages" />
		<xsl:apply-templates select="section" />

	</body>

</html>

</xsl:template>

<!-- Personal data -->

<xsl:template match="/cv/data">

<h2><xsl:value-of select="title" /></h2>

<xsl:apply-templates select="name" /><br/>
<!-- TODO: Birthday.-->
<xsl:apply-templates select="address" /><br/>
<xsl:apply-templates select="contact" /><br/>
</xsl:template>

<!-- Approach 1: Multiple templates matching all possible paths corresponding to
all child element combinations. Only acceptable when combinations are few. -->
<xsl:template match="/cv/data/name"><xsl:call-template name="formattedfullname" /></xsl:template>
<xsl:template match="/cv/data/name[title]"><xsl:value-of select="title" /><xsl:text> </xsl:text><xsl:call-template name="formattedfullname" /></xsl:template>
<xsl:template match="/cv/data/name[suffix]"><xsl:call-template name="formattedfullname" /><xsl:text></xsl:text><xsl:value-of select="suffix" /></xsl:template>
<xsl:template match="/cv/data/name[title and suffix]"><xsl:value-of select="title" /><xsl:text> </xsl:text><xsl:call-template name="formattedfullname" /><xsl:text> </xsl:text><xsl:value-of select="suffix" /></xsl:template>

<!-- Approach 2: Conditional handling of numerous, strictly-ordered optional
child element combinations. To only check for existing child elements instead of
non-empty child elements, omit the empty string comparison part. -->
<xsl:template match="/cv/data/address">
<xsl:if test="title != ''"><xsl:value-of select="title" /><br/></xsl:if>
<xsl:if test="organization != ''"><xsl:value-of select="organization" /><br/></xsl:if>
<xsl:if test="street != ''"><xsl:value-of select="street" /></xsl:if>
<xsl:if test="city != ''"><xsl:if test="street != ''">, </xsl:if><xsl:value-of select="city" /></xsl:if>
<xsl:if test="postcode != ''"><xsl:if test="street != '' or city != ''">, </xsl:if><xsl:value-of select="postcode" /></xsl:if>
<xsl:if test="country != ''"><xsl:if test="street != '' or city != '' or postcode != ''">, </xsl:if><xsl:value-of select="country" /></xsl:if>
</xsl:template>

<xsl:template match="/cv/data/contact">
<xsl:apply-templates select="email" /><br/>
<xsl:apply-templates select="telephone" /><br/>
<xsl:apply-templates select="homepage" />
</xsl:template>

<!-- Template-based handling of multiple children based on position in children
list. -->
<xsl:template match="/cv/data/contact/email[position() = 1]"><xsl:call-template name="formattedemail" /></xsl:template>
<xsl:template match="/cv/data/contact/email[position() > 1]">, <xsl:call-template name="formattedemail" /></xsl:template>
<xsl:template match="/cv/data/contact/telephone[position() = 1]"><xsl:call-template name="formattedtelephone" /></xsl:template>
<xsl:template match="/cv/data/contact/telephone[position() > 1]">, <xsl:call-template name="formattedtelephone" /></xsl:template>
<xsl:template match="/cv/data/contact/homepage[position() = 1]"><xsl:call-template name="formattedhomepage" /></xsl:template>
<xsl:template match="/cv/data/contact/homepage[position() > 1]"><br /><xsl:call-template name="formattedhomepage" /></xsl:template>

<!-- Education -->

<xsl:template match="/cv/education">
<h2><xsl:value-of select="title" /></h2>
<ul>
<xsl:apply-templates select="degree"/>
</ul>
</xsl:template>

<!-- Trivial application of approach 1 again. -->
<xsl:template match="/cv/education/degree">
<li><xsl:call-template name="formatteddegreetitle" /><xsl:call-template name="periodifneeded" /></li>
</xsl:template>
<xsl:template match="/cv/education/degree[note]">
<li><xsl:call-template name="formatteddegreetitle" /><xsl:call-template name="formatteddegreenote" /><xsl:call-template name="periodifneeded" /></li>
</xsl:template>

<!-- Languages -->

<xsl:template match="/cv/languages">
<h2><xsl:value-of select="title" /></h2>
<ul>
<xsl:apply-templates select="language"/>
</ul>
</xsl:template>

<!-- Trivial application of approach 1 again. -->
<xsl:template match="/cv/languages/language">
<li><xsl:call-template name="formattedlanguagetitle" /><xsl:call-template name="periodifneeded" /></li>
</xsl:template>
<xsl:template match="/cv/languages/language[note]">
<li><xsl:call-template name="formattedlanguagetitle" /><xsl:call-template name="formattedlanguagenote" /><xsl:call-template name="periodifneeded" /></li>
</xsl:template>

<!-- Additional sections -->

<xsl:template match="/cv/section"><h2><xsl:value-of select="title" /></h2>
<ul>
<xsl:apply-templates select="item"/>
</ul>
</xsl:template>

<!-- Approach 3: Single template and further use of xsl:choose for all possible
child element combinations. Not sure when preferable over approach 1. -->
<xsl:template match="/cv/section/item">
  <li>
	<xsl:choose>
	  <xsl:when test="start and end">
	    <xsl:value-of select="start" />-<xsl:value-of select="end" /><xsl:text>: </xsl:text>
	  </xsl:when>
      <xsl:when test="start">
        <xsl:value-of select="start" /><xsl:text>: </xsl:text>
      </xsl:when>
      <xsl:when test="end">
        Until <xsl:value-of select="end" /><xsl:text>: </xsl:text>
      </xsl:when>
    </xsl:choose><xsl:value-of select="data" /><xsl:call-template name="periodifneeded" />
  </li>
</xsl:template>

</xsl:stylesheet>
