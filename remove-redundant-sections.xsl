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

  <xsl:template match="/t:TEI">
    <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="root">
      <xsl:apply-templates/>
    </TEI>
  </xsl:template>

  <xsl:template match="t:div/t:div[string-length(t:head) = 0]">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="t:head[string-length(.) = 0]"/>
  <xsl:template match="t:head/t:lb"><xsl:text> </xsl:text></xsl:template>
  
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:transform>
