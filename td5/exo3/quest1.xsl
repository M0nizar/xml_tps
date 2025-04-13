<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/concours">
        <html>
            <head>
                <title>Résultats des Candidats</title>
            </head>
            <body>   
                <xsl:apply-templates select="grade"/>
            </body>
        </html>
    </xsl:template>
    
  
    <xsl:template match="grade">
        <h2><xsl:value-of select="@nom"/></h2>
        <xsl:apply-templates select="etablissement"/>
    </xsl:template>
    

    <xsl:template match="etablissement">
        <h3><xsl:value-of select="@nom"/></h3>
        <table border="1" cellpadding="5">-
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Moyenne</th>
                <th>Statut</th>
            </tr>
            <xsl:apply-templates select="candidat"/>
        </table>
    </xsl:template>
    
  
    <xsl:template match="candidat">
   
        <xsl:variable name="totalCoeff" select="sum(matieres/matiere/@coefficient)"/>
        
    
        <xsl:variable name="moyenne"
            select="sum(for $m in matieres/matiere return $m/@coefficient * $m/@note) div $totalCoeff"/>

    
        <xsl:variable name="ajourne" select="matieres/matiere[@note &lt; 5]"/>
        
        <tr>
            <td><xsl:value-of select="@id"/></td>
            <td><xsl:value-of select="nom"/></td>
            <td><xsl:value-of select="prenom"/></td>
            <td><xsl:value-of select="$moyenne"/></td>
            <td>
                <xsl:choose>
                    <xsl:when test="$ajourne">Ajourné</xsl:when>
                    <xsl:when test="$moyenne &gt;= 10">Admis</xsl:when>
                    <xsl:otherwise>Ajourné</xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>
    
</xsl:stylesheet>
