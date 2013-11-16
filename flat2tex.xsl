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

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" indent="no" />

<xsl:template match="/">
<xsl:apply-templates />
</xsl:template>

<xsl:template match="/cv">\documentclass[12pt]{cv}

\title{<xsl:value-of select="data/name/firstname" /><xsl:text> </xsl:text><xsl:value-of select="data/name/lastname" />}
\subtitle{Curriculum Vitae}
\date{<xsl:value-of select="@date" />}

\begin{document}

\maketitle
<xsl:apply-templates select="section" />
\end{document}
</xsl:template>

<xsl:template match="/cv/section">
\section{<xsl:value-of select="title" />}

\begin{itemize}<xsl:apply-templates select="item"/>
\end{itemize}
</xsl:template>

<xsl:template match="/cv/section/item">
  \item <xsl:choose>
    <xsl:when test="start and end">
      <xsl:value-of select="start" />--<xsl:value-of select="end" /><xsl:text>: </xsl:text>
    </xsl:when>
    <xsl:when test="start">
      <xsl:value-of select="start" /><xsl:text>: </xsl:text>
    </xsl:when>
    <xsl:when test="end">
      Until <xsl:value-of select="end" /><xsl:text>: </xsl:text>
    </xsl:when>
  </xsl:choose><xsl:value-of select="data" /><xsl:if test="substring(data, string-length(data), 1)!='.'">.</xsl:if>
</xsl:template>

</xsl:stylesheet>
