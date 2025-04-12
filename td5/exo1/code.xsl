<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
 
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    
    <!-- first question -->
    <xsl:template match="/dblpperson">
        <html>
            <head>
                <title>Liste des Documents</title>
            </head>
            <body>
                <h1>Liste des Documents Triés par Année</h1>
                <table border="1">
                    <tr>
                        <th>Type</th>
                        <th>Titre</th>
                        <th>Année</th>
                    </tr>
                    
                    <xsl:for-each select="article | inproceedings | proceedings">
                        <xsl:sort select="year" order="descending"/>
                        <tr>
                            <td><xsl:value-of select="name()"/></td>
                            <td><xsl:value-of select="titre"/></td>
                            <td><xsl:value-of select="year"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
    
    
    <!-- second question -->
    <xsl:template match="/dblpperson">
        <html>
            <head>
                <title>Articles de Conférence</title>
            </head>
            <body>
                <h1>Articles de Conférence Triés par Année</h1>
                <ul>
                    <!-- Sélectionner uniquement les inproceedings et trier par <year> -->
                    <xsl:for-each select="/dblpperson">
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
    
    <!-- tird question -->
    <xsl:template match="/dblpperson">
        <html>
            <head>
                <title>Articles de conférence filtrés</title>
            </head>
            <body>
                <h1>Articles entre 2010 et 2018 avec plus de 3 auteurs</h1>
                <ul>
                    <xsl:for-each select="/bibliography/inproceedings">
                        <xsl:choose>
                            <!-- Test 1: année -->
                            <xsl:when test="year ge 2010 and year le 2018">
                                <xsl:choose>
                                    <!-- Test 2: auteurs -->
                                    <xsl:when test="count(author) gt 3">
                                        <li>
                                            <xsl:value-of select="titre"/>
                                        </li>
                                    </xsl:when>
                                    <xsl:otherwise/>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <!-- fourth question -->
    <xsl:template match="/dblpperson">
        <resultat>
            <xsl:apply-templates select="//article[titre = 'A Survey on Privacy Preserving Dynamic Data Publishing.']"/>
        </resultat>
    </xsl:template>
    
   
    <xsl:template match="article">
        <article>
            <mdate><xsl:value-of select="@mdate"/></mdate>
            <xsl:apply-templates select="*[not(self::journal)]"/>
            <xsl:apply-templates select="journal"/>
        </article>
    </xsl:template>
    
  
    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
   
    <xsl:template match="journal">
        <journal>
            <xsl:attribute name="volume">
                <xsl:value-of select="volume"/>
            </xsl:attribute>
        </journal>
    </xsl:template>
    
    <!-- fifth question -->
    <xsl:template match="/dblpperson">
        <html>
            <head>
                <title>Articles Benslimane DBLP</title>
            </head>
            <body>     
                <table border="1">
                    <tr>
                        <th>Citation</th>
                        <th>Type de papier</th>
                    </tr>
                   
                    <xsl:for-each select="//article">
                        <tr>
                            <td>
                                <xsl:value-of select="concat(author, ' (', year, ') ', title, '. ', url)"/>
                            </td>                       
                            <td>
                                <xsl:choose>
                                    <!-- Si pages existe, on regarde son contenu -->
                                    <xsl:when test="pages">
                                        <xsl:choose>                                         
                                            <xsl:when test="number(pages) &gt;= 1 and number(pages) &lt;= 8">Short paper</xsl:when>                                         
                                            <xsl:when test="number(pages) &gt; 8">Long paper</xsl:when>
                                        </xsl:choose>
                                    </xsl:when>                               
                                    <xsl:otherwise>
                                        Unspecified
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