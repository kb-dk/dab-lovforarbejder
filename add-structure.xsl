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
                <xsl:choose>
                  <xsl:when test="$registrant//row[contains(Filnavne,$volume_number)]/Udgivelsesår">
                    <xsl:value-of select="$registrant//row[contains(Filnavne,$volume_number)]/Udgivelsesår"/>
                  </xsl:when>
                  <xsl:when test="$registrant//row[contains(Filnavne,$volume_number)]/Skrevet/fremsatDato">
                    <xsl:value-of select="$registrant//row[contains(Filnavne,$volume_number)]/Skrevet/fremsatDato"/>
                  </xsl:when>
                  <xsl:otherwise>qwertyqwerty</xsl:otherwise>
                </xsl:choose>
              </date>
            </bibl>
          </sourceDesc>
        </fileDesc>
      </teiHeader>
      <text>
        <body>
          <title type="replace-with-title-page"><xsl:value-of select="$registrant//row[contains(Filnavne,$volume_number)]/Titel"/></title>
          <xsl:apply-templates/>
        </body>
      </text>
    </TEI>

  </xsl:template>

  <xsl:template match="t:div[@type='page-placeholder']">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="t:leftside|t:rightside">
    <xsl:variable name="id"><xsl:value-of select="generate-id(.)"/></xsl:variable>
    <xsl:variable name="column"><xsl:call-template name="get-column"/></xsl:variable>
    <xsl:if test="number($column)">
      <xsl:element name="milestone">
        <xsl:attribute name="type"><xsl:call-template name="milestone-type"/></xsl:attribute>
        <xsl:attribute name="xml:id"><xsl:value-of select="concat('start',$id)"/></xsl:attribute>
        <xsl:attribute name="next"><xsl:value-of select="concat('end',$id)"/></xsl:attribute>
        <xsl:attribute name="n"><xsl:value-of select="number($column)"/></xsl:attribute>
        <xsl:attribute name="unit">column</xsl:attribute>
      </xsl:element>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:if test="number($column)">
      <xsl:element name="milestone">
        <xsl:attribute name="type"><xsl:call-template name="milestone-type"/></xsl:attribute>
        <xsl:attribute name="xml:id"><xsl:value-of select="concat('end',$id)"/></xsl:attribute>
        <xsl:attribute name="prev"><xsl:value-of select="concat('start',$id)"/></xsl:attribute>
        <xsl:attribute name="n"><xsl:value-of select="number($column)"/></xsl:attribute>
        <xsl:attribute name="unit">column</xsl:attribute>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template name="get-column">
    <xsl:choose>
      <xsl:when test="local-name(.) = 'leftside'">
        <xsl:value-of select="../t:h/t:coll"/>
      </xsl:when>
      <xsl:when test="local-name(.) = 'rightside'">
        <xsl:value-of select="../t:h/t:colr"/>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="running-head" match="t:h">
    <xsl:element name="fw">
      <xsl:attribute name="type">head</xsl:attribute>
      <xsl:attribute name="place">top-left</xsl:attribute>
      <xsl:value-of select="t:coll"/>
    </xsl:element>
    <xsl:element name="fw">
      <xsl:attribute name="type">head</xsl:attribute>
      <xsl:attribute name="place">top-middle</xsl:attribute>
      <xsl:value-of select="t:topmidle"/>
    </xsl:element>
    <xsl:element name="fw">
      <xsl:attribute name="type">head</xsl:attribute>
      <xsl:attribute name="place">top-right</xsl:attribute>
      <xsl:value-of select="t:colr"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="milestone-type">
    <xsl:choose>
      <xsl:when test="@type"><xsl:value-of select="@type"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="local-name(.)"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="t:law">
    <span type="law"><xsl:apply-templates select="@*"/><xsl:apply-templates/></span> 
  </xsl:template>
  
  <xsl:template match="t:signature|t:signaturlist">
    <p><xsl:comment> originally  signature or signaturlist</xsl:comment><xsl:apply-templates/></p>
  </xsl:template>
  
  <xsl:template match="t:notedate">
    <p><xsl:comment> dateline </xsl:comment><xsl:apply-templates select="@*|node()"/></p>
  </xsl:template>

  <xsl:template match="t:namelist|t:indexlist|t:reflist">
    <xsl:comment> a <xsl:value-of select="local-name()"/> element below </xsl:comment>
    <p><xsl:apply-templates/></p>
  </xsl:template>
  
  <xsl:template match="node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="@*">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="processing-instruction('page')">
    <xsl:element name="pb">
      <xsl:attribute name="xml:id">id<xsl:value-of select="."/></xsl:attribute>
      <xsl:attribute name="facs"><xsl:value-of select="normalize-space(.)"/></xsl:attribute>
    </xsl:element>
  </xsl:template>
  
</xsl:transform>


