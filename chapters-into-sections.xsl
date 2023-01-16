<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns="http://www.tei-c.org/ns/1.0"
               xmlns:t="http://www.tei-c.org/ns/1.0"
               version="3.0">

  <xsl:variable name="registrant" select="document('registrant-dab-lovsamlinger-20230109.xml')"/>
  <xsl:param name="volume_number"/>

  <xsl:output indent="yes" encoding="UTF-8" />

  <xsl:template match="/t:TEI">
    <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="root">
      <xsl:apply-templates/>
    </TEI>
  </xsl:template>
  
  <xsl:template match="t:undertitle">
    <head><xsl:apply-templates/></head>
  </xsl:template>

  <xsl:template  match="t:div/t:wtitle">
    <xsl:variable name="me" select="generate-id(.)"/>
    <xsl:element name="div">
      <xsl:element name="head"><xsl:apply-templates/></xsl:element>
      <xsl:apply-templates select="following-sibling::node()[not(local-name(.) = 'wtitle') and generate-id(preceding-sibling::t:wtitle[1]) = $me]"/>
    </xsl:element>
    <xsl:apply-templates  select="following-sibling::t:wtitle[1]"/>
  </xsl:template>

    <xsl:template  match="t:div/t:lowtitle">
    <xsl:variable name="me" select="generate-id(.)"/>
    <xsl:element name="div">
      <xsl:element name="head"><xsl:apply-templates/></xsl:element>
      <xsl:apply-templates select="following-sibling::node()[not(local-name(.) = 'lowtitle') and generate-id(preceding-sibling::t:lowtitle[1]) = $me]"/>
    </xsl:element>
    <xsl:apply-templates  select="following-sibling::t:lowtitle[1]"/>
  </xsl:template>

  
  <xsl:template match="node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="@*">
    <xsl:copy-of select="."/>
  </xsl:template>
  
</xsl:transform>

