<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:f="myfunctions"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0"
                exclude-result-prefixes="f">
   <xsl:variable name="sq">'</xsl:variable>
   <xsl:variable name="dq">"</xsl:variable>
   <xsl:variable name="true" select="tokenize('true yes on 1','\s+')"/>
   <xsl:variable name="usxpath" select="'D:\usx-collection\agp'"/>
   <xsl:variable name="divider" select="'&#x9;'"/>
   <xsl:variable name="outfile" select="'fig-table.txt'"/>
   <xsl:variable name="script" select="'USX-fig-table.xslt'"/>
</xsl:stylesheet>
