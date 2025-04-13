<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <!-- fourth question -->
    <xsl:template match="/">
        <resultat>
            <xsl:apply-templates select="//article[title = 'A Survey on Privacy Preserving Dynamic Data Publishing.']"/>
        </resultat>
    </xsl:template>
    
    
    <xsl:template match="article">
        <article>
            <mdate><xsl:value-of select="@mdate"/></mdate>
            <xsl:apply-templates select="*[not(self::journal)]"/>
            <xsl:apply-templates select="journal"/>
        </article>
    </xsl:template>
    
    <xsl:template match="journal">
        <journal>
            <xsl:attribute name="volume">
                <xsl:value-of select="volume"/>
            </xsl:attribute>
        </journal>
    </xsl:template>
</xsl:stylesheet>
