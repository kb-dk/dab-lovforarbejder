<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	       xmlns:t="http://www.tei-c.org/ns/1.0"
	       xmlns="http://www.tei-c.org/ns/1.0"
               xmlns:a="http://www.loc.gov/standards/alto/ns-v3#"
               xmlns:h="http://www.w3.org/1999/xhtml"
               xmlns:xlink="http://www.w3.org/1999/xlink"
	       exclude-result-prefixes="t xlink h a"
	       version="2.0">

  <xsl:output
      method="xml"
      encoding="UTF-8"/>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="/t:TEI">
    <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="root">
      <xsl:apply-templates/>
    </TEI>
  </xsl:template>

  <xsl:template match="t:*">
    <xsl:element name="{name()}">
      <xsl:if test="not(@xml:id)">
	<xsl:attribute name="xml:id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
 </xsl:template>

 <xsl:template match="@*">
   <xsl:variable name="attribute" select="name(.)"/>
   <xsl:if test="not(name(.) = 'id')">
     <xsl:attribute name="{$attribute}">
       <xsl:value-of select="."/>
     </xsl:attribute>
   </xsl:if>
 </xsl:template>

</xsl:transform>
