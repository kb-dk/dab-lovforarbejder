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
          <xsl:copy-of select="/t:TEI/*"/>
        </body>
      </text>
    </TEI>

  </xsl:template>

</xsl:transform>


