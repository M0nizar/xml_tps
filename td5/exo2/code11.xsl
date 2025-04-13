<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>Pays avec population la plus récente</title>
            </head>
            <body>
                <ul>
                    <xsl:for-each select="//country">
                        <xsl:apply-templates select="population[last()]"/>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="population">
        <xsl:if test=". &gt;= 9000000 and . &lt;= 10000000">
            <li>
                <strong><xsl:value-of select="../name"/> :</strong>
                <p><strong>Population :</strong> <xsl:value-of select="."/></p>
                <p><strong>Année :</strong> <xsl:value-of select="@year"/></p>
            </li>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>