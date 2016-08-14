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

  <data:entry key="a">abcdefghijklmnopqrstuvwxyz</data:entry>
  <data:entry key="b">bcdefghijklmnopqrstuvwxyza</data:entry>
  <data:entry key="c">cdefghijklmnopqrstuvwxyzab</data:entry>
  <data:entry key="d">defghijklmnopqrstuvwxyzabc</data:entry>
  <data:entry key="e">efghijklmnopqrstuvwxyzabcd</data:entry>
  <data:entry key="f">fghijklmnopqrstuvwxyzabcde</data:entry>
  <data:entry key="g">ghijklmnopqrstuvwxyzabcdef</data:entry>
  <data:entry key="h">hijklmnopqrstuvwxyzabcdefg</data:entry>
  <data:entry key="i">ijklmnopqrstuvwxyzabcdefgh</data:entry>
  <data:entry key="j">jklmnopqrstuvwxyzabcdefghi</data:entry>
  <data:entry key="k">klmnopqrstuvwxyzabcdefghij</data:entry>
  <data:entry key="l">lmnopqrstuvwxyzabcdefghijk</data:entry>
  <data:entry key="m">mnopqrstuvwxyzabcdefghijkl</data:entry>
  <data:entry key="n">nopqrstuvwxyzabcdefghijklm</data:entry>
  <data:entry key="o">opqrstuvwxyzabcdefghijklmn</data:entry>
  <data:entry key="p">pqrstuvwxyzabcdefghijklmno</data:entry>
  <data:entry key="q">qrstuvwxyzabcdefghijklmnop</data:entry>
  <data:entry key="r">rstuvwxyzabcdefghijklmnopq</data:entry>
  <data:entry key="s">stuvwxyzabcdefghijklmnopqr</data:entry>
  <data:entry key="t">tuvwxyzabcdefghijklmnopqrs</data:entry>
  <data:entry key="u">uvwxyzabcdefghijklmnopqrst</data:entry>
  <data:entry key="v">vwxyzabcdefghijklmnopqrstu</data:entry>
  <data:entry key="w">wxyzabcdefghijklmnopqrstuv</data:entry>
  <data:entry key="x">xyzabcdefghijklmnopqrstuvw</data:entry>
  <data:entry key="y">yzabcdefghijklmnopqrstuvwx</data:entry>
  <data:entry key="z">zabcdefghijklmnopqrstuvwxy</data:entry>

  <func:function name="vigenere:encrypt">
    <xsl:param name="code"/>
    <xsl:param name="text"/>
    <xsl:variable name="length" select="string-length($text)"/>
    <xsl:variable name="pad"    select="str:padding($length, $code)"/>
    <xsl:variable name="abc"    select="document('')//data:entry[@key='a']/text()"/>
    <func:result>
      <xsl:for-each select="str:tokenize($text, '')">
        <xsl:variable name="chr" select="substring($pad, position(), 1)"/>
        <xsl:variable name="sub" select="document('')//data:entry[@key=$chr]/text()"/>
        <xsl:value-of select="translate(., $abc, $sub)"/>
      </xsl:for-each>
    </func:result>
  </func:function>

  <func:function name="vigenere:decrypt">
    <xsl:param name="code"/>
    <xsl:param name="text"/>
    <xsl:variable name="length" select="string-length($text)"/>
    <xsl:variable name="pad"    select="str:padding($length, $code)"/>
    <xsl:variable name="abc"    select="document('')//data:entry[@key='a']/text()"/>
    <func:result>
      <xsl:for-each select="str:tokenize($text, '')">
        <xsl:variable name="chr" select="substring($pad, position(), 1)"/>
        <xsl:variable name="sub" select="document('')//data:entry[@key=$chr]/text()"/>
        <xsl:value-of select="translate(., $sub, $abc)"/>
      </xsl:for-each>
    </func:result>
  </func:function>

</xsl:stylesheet>
