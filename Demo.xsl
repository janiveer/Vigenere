<?xml version="1.0" encoding="UTF-8"?>

<!--
     Copyright © 2016 Simon Dew.

     This file is part of the XSLT Vigenère library.

     The XSLT Vigenère library is free software: you can redistribute it and/or modify it
     under the terms of the GNU Lesser General Public License as published by the Free
     Software Foundation, either version 3 of the License, or (at your option) any later
     version.

     The XSLT Vigenère library  is distributed in the hope that it will be useful, but
     WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
     FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
     more details.

     You should have received a copy of the GNU Lesser General Public License
     along with the XSLT Vigenère library . If not, see http://www.gnu.org/licenses/.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                xmlns:func="http://exslt.org/functions"
                xmlns:data="urn:x-vigenere:data"
                xmlns:vigenere="urn:x-vigenere:function"
                extension-element-prefixes="func"
                exclude-result-prefixes="func data str vigenere"
                version="1.1">

  <xsl:output method="text" encoding="UTF-8"/>
  <xsl:include href="Vigenere.xsl"/>

  <xsl:template match="properties">
    <xsl:variable name="code" select="entry[@key='code']/text()"/>
    <xsl:choose>
      <xsl:when test="$code">
        <xsl:apply-templates select="entry[@key='cypher']|entry[@key='plain']">
          <xsl:with-param name="code" select="$code"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message terminate="yes">
          <xsl:text>No key code found.</xsl:text>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="entry[@key='cypher']">
    <xsl:param name="code"/>
    <xsl:value-of select="vigenere:decrypt($code, text())"/>
    <xsl:text>&#x0d;&#x0a;</xsl:text>
  </xsl:template>

  <xsl:template match="entry[@key='plain']">
    <xsl:param name="code"/>
    <xsl:value-of select="vigenere:encrypt($code, text())"/>
    <xsl:text>&#x0d;&#x0a;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
