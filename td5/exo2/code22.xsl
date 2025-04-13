<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>Pays avec plusieurs langues</title>
            </head>
            <body>
                <table border="1" cellpadding="5">
                    <tr>
                        <th>Country</th>
                        <th>Population</th>
                        <th>Area</th>
                        <th>Number of Languages</th>
                    </tr>
                    
                    <xsl:for-each select="//country[count(language) &gt; 1]">
                        <xsl:sort select="count(language)" data-type="number" order="descending"/>
                        
                        <tr>
                            <td><strong><xsl:value-of select="name"/></strong></td>
                            <td><xsl:value-of select="population[last()]"/></td>
                            <td><xsl:value-of select="@area"/></td>
                            <td><xsl:value-of select="count(language)"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>