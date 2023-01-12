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
      <teiHeader>
        <fileDesc>
          <titleStmt>
            <title>
              <xsl:value-of select="$registrant//row[contains(Filnavne,$volume_number)]/Titel"/>
            </title>
          </titleStmt>
          <publicationStmt>
            <p/>
          </publicationStmt>
          <sourceDesc>
            <bibl>
              <title>
                <xsl:value-of select="$registrant//row[contains(Filnavne,$volume_number)]/Titel"/>
              </title>
              <date>
                <xsl:value-of select="$registrant//row[contains(Filnavne,$volume_number)]/Udgivelsesår"/>
              </date>
            </bibl>
          </sourceDesc>
        </fileDesc>
      </teiHeader>
      <text>
        <body>
          <xsl:apply-templates/>
        </body>
      </text>
    </TEI>

  </xsl:template>

  <xsl:template match="node()">
    <xsl:copy>
      <!-- xsl:if test="not(@id)">
        <xsl:attribute name="id">
          <xsl:value-of select="generate-id(.)"/>
        </xsl:attribute>
      </xsl:if -->
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="@*">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="processing-instruction('page')">
    <xsl:element name="pb">
      <xsl:attribute name="xml:id"><xsl:value-of select="."/></xsl:attribute>
    </xsl:element>
  </xsl:template>
  
</xsl:transform>


