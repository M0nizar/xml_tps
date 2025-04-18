# Homework LOW

* summaries for some concepts :
1. template :
* An element in XSLT defines how a specific node or pattern will transform.
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
----
2. apply-template :
* an xslt instruction that look for matching templates by comparing the select value with match value of the template.
**Syntax :**
```xslt
<xsl:apply-template select="xpath expression"/>
```
**Exemple :**   

**xml file :**  
* same as the file used in the previous concept.  

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
* same result as the preevious concept.
----
3. call-template :
* an xslt instruction that used for calling a named template works like manual trigger unlike apply-template witch is automatically finds the template.
**Syntax :**
```xslt
<xsl:call-template name="name of the template"/>
```
**Exemple:**  

**xml file :**  
* same as the file used in the previous concept.  

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
* same result as the preevious concept.
----
4. functions :
* xslt 1.0 does not support custom functions (user defined functions) but it does in the 2.0 version.
* xslt 1.0 only support built-in functions witch are tools that helps us manipulate data with its different types (string(),concat(a,b),number(),position().....).  
* in 1.0 version user can simulate functions with named templates and call it with call-template.  

**Exemple:**
```xslt
<xsl:template name="used_template">
  <xsl:param name="name"/>
  name : <xsl:value-of select="$name"/>
</xsl:template>
```
* in 2.0 version user can define functions like that :  
```xslt
<xsl:function name="function_name" as="xs:output-type">
  <!--define parametres = arguments-->
  <xsl:param name="a" as="xs:para-type"/>

  <!--the return done by using sequence -->
  <xsl:sequence select="expression-to-return"/>
</xsl:function>
```
## Part two:
### Exercise one :
1. List all albums in ascending alphabetical order :
```
for $v in doc("albums.xml")//album
order by $v/titre
return $v
```
2. Albums published after 1970 :
```
doc("albums.xml")//album[date/annee>1970]
```
3. Authors who participated in more than one album :
```
for $v in distinct-values(doc("albums.xml")//auteur)
let $count := count(doc("albums.xml")//auteur[. = $v])
where $count > 1
return $v

```
4. Find the most recent album of each series :
```
for $v in distinct-values(doc("albums.xml")//album/@serie)
let $s := doc("albums.xml")//album[@serie = $v]
let $recent := max($s/date/annee)
return <serie name="{$v}">
     {
    for $a in $s[./date/annee = $recent]
    return $a
  }
</serie>
```
5. Group albums by series and count the number of albums per series :
```
for $v in doc("albums.xml")//album
let $s := $v/@serie
group by $s
return
  <serie name="{$s}" count="{count($v)}">
    {
      for $i in $v
      return $i
    }
  </serie>

```
6. Find the series with the most albums :
```
let $count :=
  for $s in distinct-values(doc("albums.xml")//album/@serie)
  let $a := doc("albums.xml")//album[@serie = $s]
  return <serie name="{$s}" count="{count($a)}"/>

let $maxCount := max($count/@count/xs:integer(.))

for $serie in $count[@count = $maxCount]
return $serie
```
7. Find the years where the most albums were published :
```
let $counts :=
  for $v in distinct-values(doc("albums.xml")//album/date/annee)
  let $a := doc("albums.xml")//album[date/annee = $v]
  return <annee year="{$v}" count="{count($a)}"/>

let $max := max($counts/@count)

for $c in $counts[@count = $max]
return $c
```
8. List albums published more than 10 years apart from the previous album in the same series :
```
for $serie in distinct-values(doc("albums.xml")//album/@serie)
let $albums := doc("albums.xml")//album[@serie = $serie]
let $sortedAlbums := sort($albums, function($a, $b) {xs:dateTime($a/date/annee) < xs:dateTime($b/date/annee)})
let $previous := ()
for $album in $sortedAlbums
let $dateDiff := if (empty($previous)) then 0 else xs:int($album/date/annee) - xs:int($previous/date/annee)
let $previous := $album
where $dateDiff > 10
```
9. Find authors who participated in multiple different series :
```
for $author in distinct-values(doc("albums.xml")//auteur)
let $series := distinct-values(doc("albums.xml")//album[auteur = $author]/@serie)
where count($series) > 1
return $author
```
10. Identify the author who wrote the most albums :
```
let $authors := doc("albums.xml")//auteur
let $count-by-author := for $author in distinct-values($authors)
                        let $count := count(doc("albums.xml")//auteur[. = $author])
                        return <author name="{$author}" count="{$count}"/>
let $max-count := max($count-by-author//author/@count)
for $author in $count-by-author
where $author/@count = $max-count
return $author

```
18. Display albums with exactly the same title but in a different series :
19. Declare and invoke a function to get the oldest albums by an author (e.g., "Hergé") :
20. Add the author "Uderzo" to album number 1 of the "Tintin" series :
21. Add an "éditeur" attribute "La plume" to album number 3 of the "Astérix" series :
22. Add the author "Hergé" to all albums of the "Tintin" series that don’t already have him :
23. Change the "serie" attribute of all "Astérix" albums to "Astérix et Obélix" :
24. Remove all albums from the "Tintin" series published before 1950 :
25. Increase the publication year of all "Astérix" albums after 1980 :
26. Change the "album" element of the first album of each series to "Premier_album" :
27. Add a new album at the end of the "Tintin" series :
----
### Exercise two :
1. Title, genre, and country for all films before 1970 :
2. Roles played by Bruce Willis :
3. Roles played by Bruce Willis in the form of an element with the title of the film and the character name :
4. The name of the director of the movie "Vertigo" :
5. For each artist, their name and the titles of the films they directed :
6. For each film, the age of its director at the time of the film’s release :
7. For each film genre, produce an element with the genre name as an attribute and containing the titles of the films in that genre :
8. Artists who played in a film they directed. For each artist, create an element with their full name (first name followed by last name), and include film elements containing the title and year of the film :
