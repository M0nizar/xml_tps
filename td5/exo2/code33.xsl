<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <Result>
            <xsl:for-each select="//country">
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
