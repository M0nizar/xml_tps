<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    
    
    <!-- question 1 -->
    <xsl:template match="/mondial">
        <html>
            <head>
                <title>Pays avec population la plus récente</title>
            </head>
            <body>
                <ul>
                    <xsl:for-each select="country">               
                        <xsl:apply-templates select="population[last()]"/>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="population">
        <xsl:if test="population &gt;= 9000000 and population &lt;= 10000000">
            <li>
                <strong><xsl:value-of select="name"/>:</strong>
                <p><strong>Population:</strong> <xsl:value-of select="."/></p>
                <p><strong>Year of Population:</strong> <xsl:value-of select="@year"/></p>
            </li>
        </xsl:if>
    </xsl:template>
    
    
    <!-- question 2 -->
    <xsl:template match="/mondial">
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
                        <tr>
                           
                            <td><strong><xsl:value-of select="name"/></strong></td>
                            
                         
                            <td>
                                <xsl:value-of select="population[last()]"/>
                            </td>
                            
                            <td>
                                <xsl:value-of select="@area"/>
                            </td>
                            <td>
                                <xsl:value-of select="count(language)"/>
                            </td>
                        </tr>
                    </xsl:for-each>                  
                </table>
            </body>
        </html>
    </xsl:template>
    
    <!-- question 3 -->
    
    <xsl:template match="/mondial">
        <Result>
            <xsl:for-each select="country">
                <country 
                    languages="{count(language)}" 
                    cities="{count(city)}">     
                    <name>
                        <xsl:value-of select="name"/>
                    </name>
                    <population>
                        <xsl:value-of select="population[last()]"/>
                    </population>
                </country>
            </xsl:for-each>
        </Result>
    </xsl:template>
</xsl:stylesheet>