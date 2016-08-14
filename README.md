# Vigenère

Vigenère cypher library for XSLT

## Introduction

This is an XSLT library which enables you to encrypt plain text or decrypt cypher text
using the [Vigenère cypher](https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher). It’s
almost completely useless for security purposes. However this cypher turns up relatively
frequently in the books I’ve been reading lately, so I wrote this library for fun and
convenience.

The name Vigenère properly includes a grave accent. I’ve omitted the accent in file
names, namespaces, namespace prefixes and repository names, to avoid possible problems
with accented characters. I know, it shouldn’t be a problem in this day and age, but
still...

## Prerequisites

An XSLT processor compatible with [XSLT 1.0 or 1.1](http://www.w3.org/TR/xslt) and
[eXSLT](http://exslt.org/). It works with [XSLTProc](http://xmlsoft.org/libxslt/).

## Vigenere.xsl

This provides two functions:

  * `vigenere:decrypt(code, cypher_text)` decrypts the `cypher_text` using the key `code` provided.
  * `vigenere:encrypt(code, plain_text)` encrypts the `plain_text` using the key `code` provided.

The libraries make use of a [Tabula recta](https://en.wikipedia.org/wiki/Tabula_recta). I
could have used modular arithmetic to perform the encryption and decryption, but I found
this method easier to visualise.

The `plain_text` and the `cypher_text` must _only_ contain lower case alphabetical
characters with no accents; i.e. no numbers, spaces or punctuation. This is not enforced
by the library at the moment. If this condition is not met, the library will generate
incorrect results.

## Demo.xsl

This stylesheet demonstrates how the library works. It reads a source file in [XML Java
Properties](http://docs.oracle.com/javase/7/docs/api/java/util/Properties.html) format.
(The choice of this format is not particularly significant; it’s just a handy,
established XML format for storing key / value pairs.)

The source file must contain a `code` entry containing the key code, and either a `plain`
entry containing plain text or a `cypher` entry containing cypher text. If the `cypher`
entry is present, the stylesheet decrypts the cypher text; otherwise, if the `plain`
entry is present, the stylesheet encrypts the plain text.

I’ve also provided a few example files.

### Examples

<pre>
	xsltproc Vigenere.xsl Feel_the_Fear.xml
</pre>

<pre>
	xsltproc Vigenere.xsl Red_Shift.xml
</pre>

### Note

It’s possible to use the decryption operation on plain text, giving a different cypher
text to what you would get using the encryption operation. Cypher text encrypted in this
way must be decrypted using the encryption operation. An example of this is shown in the
file `Red_Shift.xml`. The cypher text has been encrypted using the decription operation.
It is stored in the `plain` entry in the source file; this forces the demo stylesheet to
decrypt it using the encryption operation.



