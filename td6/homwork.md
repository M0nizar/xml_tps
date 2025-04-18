# Homework LOW
## Part one:
summaries for some concepts :
1. template :
An element in XSLT defines how a specific node or pattern will transform.
**Syntax :**
```xslt
<xsl:template match="condition" name="name">
<!-- actions -->
</xsl:template>
```
>condition : is an xpath xpression for specific nodes
>
>actions : how going to tranform the node
>
>name :  a name for the template can be used in call-template

**Exemple :**

**xml file :**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<students>
  <student>
    <name>Ali Bencheikh</name>
    <birthday>2001-05-12</birthday>
  </student>
  <student>
    <name>Sarah Amrani</name>
    <birthday>2000-11-23</birthday>
  </student>
<students>
```
**xslt file :**
```xslt
  <xsl:template match="/">
    <html>
      <body>
        <xsl:for-each select="students/student">
          Name: <xsl:value-of select="name"/><br/>
          Birthday: <xsl:value-of select="birthday"/><br/><br/>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
```
**result :**
```
Name: Ali Bencheikh
Birthday: 2001-05-12

Name: Sarah Amrani
Birthday: 2000-11-23
```
2. apply-template :
an xslt instruction that look for matching templates by comparing the select value with match value of the template.
**Syntax :**
```xslt
<xsl:apply-template select="xpath expression"/>
```
**Exemple :**   

**xml file :**  
same as the file used in the previous concept.  

**xslt file :**
```xslt
  <xsl:template match="/">
  <xsl:apply-template select="students/student"/>
  </xsl:template>
  <xsl:template match="student">
    <html>
      <body>
          Name: <xsl:value-of select="name"/><br/>
          Birthday: <xsl:value-of select="birthday"/><br/><br/>
      </body>
    </html>
  </xsl:template>
```

**result :**  
same result as the preevious concept.

3. call-template :
an xslt instruction that used for calling a named template works like manual trigger unlike apply-template witch is automatically finds the template.
**Syntax :**
```xslt
<xsl:call-template name="name of the template"/>
```
**Exemple:**  

**xml file :**  
same as the file used in the previous concept.  

**xslt file :** 
```xslt
  <xsl:template match="/">
  <xsl:call-template name="used_template"/>
  </xsl:template>
  <xsl:template name="used_template">
    <html>
      <body>
          Name: <xsl:value-of select="name"/><br/>
          Birthday: <xsl:value-of select="birthday"/><br/><br/>
      </body>
    </html>
  </xsl:template>
```

**result :**  
same result as the preevious concept.

6. functions :
xslt 1.0 does not support custom functions (user defined functions) but it does in the 2.0 version.
xslt 1.0 only support built-in functions witch are tools that helps us manipulate data with its different types (string(),concat(a,b),number(),position().....).
in 1.0 version user can simulate functions with named templates and call it with call-template.
Exemple:
```xslt
<xsl:template name="used_template">
  <xsl:param name="name"/>
  name : <xsl:value-of select="$name"/>
</xsl:template>
```
in 2.0 version user can define functions like that :  
```xslt
<xsl:function name="function_name" as="xs:output-type">
  <xsl:param name="a" as="xs:para-type"/>
  <xsl:param name="b" as="xs:para-type"/>
  <xsl:sequence select="$a + $b"/>
</xsl:function>
```

