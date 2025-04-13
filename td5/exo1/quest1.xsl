<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <!-- first question -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Liste des Documents</title>
            </head>
            <body>
                <table border="1">
                    <tr>
                        <th>Type</th>
                        <th>Titre</th>
                        <th>Année</th>
                    </tr>
                    
                    <xsl:for-each select="//article | //inproceedings | //proceedings">
                        <xsl:sort select="year" order="descending"/>
                        <tr>
                            <td><xsl:value-of select="name()"/></td>
                            <td><xsl:value-of select="title"/></td>
                            <td><xsl:value-of select="year"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>