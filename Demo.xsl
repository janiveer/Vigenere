<?xml version="1.0" encoding="UTF-8"?>

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
    <xsl:variable name="code"   select="entry[@key='code']/text()"/>
    <xsl:variable name="cypher" select="entry[@key='cypher']/text()"/>
    <xsl:variable name="plain"  select="entry[@key='plain']/text()"/>
    <xsl:choose>
      <xsl:when test="$code">
        <xsl:choose>
          <xsl:when test="$cypher">
            <xsl:value-of select="vigenere:decrypt($code, $cypher)"/>
            <xsl:text>&#x0d;&#x0a;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$plain">
                <xsl:value-of select="vigenere:encrypt($code, $plain)"/>
                <xsl:text>&#x0d;&#x0a;</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:message terminate="yes">
                  <xsl:text>No cypher text or plain text found.</xsl:text>
                </xsl:message>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message terminate="yes">
          <xsl:text>No key code found.</xsl:text>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
