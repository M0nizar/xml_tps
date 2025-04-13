<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Articles de conférence filtrés</title>
            </head>
            <body>
                <h1>Articles entre 2010 et 2018 avec plus de 3 auteurs</h1>
                <ul>
                    <xsl:for-each select="//inproceedings[number(year) ge 2010 and number(year) le 2018 and count(author) gt 3]">
                        <li>
                            <xsl:value-of select="title"/>
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="year"/>
                            <xsl:text>)</xsl:text>
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>
