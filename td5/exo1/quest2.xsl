<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <!-- second question -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Articles de Conférence</title>
            </head>
            <body>
                <h1>Articles de Conférence Triés par Année</h1>
                <ul>
                    <xsl:for-each select="//inproceedings">
                        <xsl:sort select="year" order="descending" data-type="number"/>
                        <li>
                            <p><strong>Titre:</strong> <xsl:value-of select="titre"/></p>
                            <p><strong>Nombre d'auteurs:</strong> <xsl:value-of select="count(author)"/></p>
                            <p><strong>Conférence:</strong> <xsl:value-of select="booktitle"/></p>
                            <p><strong>Année:</strong> <xsl:value-of select="year"/></p>
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>