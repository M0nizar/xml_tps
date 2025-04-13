<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <!-- fifth question -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Articles Benslimane DBLP</title>
            </head>
            <body>
                <h2>Liste des articles</h2>
                <table border="1" cellpadding="5" cellspacing="0">
                    <tr>
                        <th>Citation</th>
                        <th>Type de papier</th>
                    </tr>
                    
                    <xsl:for-each select="//article">
                        <tr>
                            <td>
                                <xsl:for-each select="author">
                                    <xsl:value-of select="."/>
                                    <xsl:if test="position() != last()">, </xsl:if>
                                </xsl:for-each>
                                <xsl:text> (</xsl:text>
                                <xsl:value-of select="year"/>
                                <xsl:text>) </xsl:text>
                                <xsl:value-of select="title"/>
                                <xsl:text>. </xsl:text>
                                <xsl:value-of select="url"/>
                            </td>
                            
                            <td>
                                <!-- Handle both page ranges and single pages -->
                                <xsl:variable name="cleanPages" select="normalize-space(pages)"/>
                                
                                <xsl:choose>
                                    <!-- For single pages (e.g., 345) -->
                                    <xsl:when test="not(contains($cleanPages, '-')) and number($cleanPages) &gt; 0">
                                        
                                        <xsl:choose>
                                            <xsl:when test="number(cleanPages) &lt;= 8">Short paper</xsl:when>
                                            <xsl:when test="number(cleanPages) &gt; 8">Long paper</xsl:when>
                                            <xsl:otherwise>Unspecified</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    
                                    <!-- For page ranges (e.g., 24-45) -->
                                    <xsl:when test="contains($cleanPages, '-')">
                                        <xsl:variable name="start" select="number(substring-before($cleanPages, '-'))"/>
                                        <xsl:variable name="end" select="number(substring-after($cleanPages, '-'))"/>
                                        <xsl:variable name="count" select="$end - $start + 1"/>
                                        
                                        <xsl:choose>
                                            <xsl:when test=" $count &lt;= 8">Short paper</xsl:when>
                                            <xsl:when test=" $count &gt; 8">Long paper</xsl:when>
                                            <xsl:otherwise>Unspecified</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    
                                    <!-- If no valid page or range, return Unspecified -->
                                    <xsl:otherwise>
                                        <xsl:text>Unspecified</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>
