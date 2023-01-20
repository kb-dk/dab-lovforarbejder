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

  <xsl:template match="t:text/t:body">
    <body>
      <xsl:apply-templates select="@*"/>
      <xsl:for-each select="t:div">
        <div>
          <xsl:apply-templates select="@*"/>
          <xsl:attribute name="xml:id">
            <xsl:value-of select="concat('chptr',generate-id(.))"/>
          </xsl:attribute>
          <xsl:attribute name="decls">
            <xsl:value-of select="concat('bibl-chptr',generate-id(.))"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </div>
      </xsl:for-each>
    </body>
  </xsl:template>

  <xsl:template match="t:fileDesc/t:sourceDesc">
    <sourceDesc>
      <xsl:copy-of select="t:bibl"/>
      <xsl:element name="listBibl">
        <xsl:for-each select="//t:text/t:body/t:div">
          <bibl>
            <xsl:attribute name="xml:id">
              <xsl:value-of select="concat('bibl-chptr',generate-id(.))"/>
            </xsl:attribute>
            <title><xsl:value-of select="t:head[1]"/></title>
          </bibl>
        </xsl:for-each>
      </xsl:element>
    </sourceDesc>
  </xsl:template>
  
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:transform>
