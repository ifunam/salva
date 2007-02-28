<?xml version="1.0" ?>
        <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
        <xsl:template match="/">
          <xsl:element name="html">
            <xsl:element name="head">
              <xsl:element name="title">Curriculum</xsl:element>
            </xsl:element>

            <xsl:element name="body">
              <xsl:element name="p"><xsl:value-of select="resume/person/lastname1" /></xsl:element>
              <xsl:element name="p"><xsl:value-of select="resume/person/lastname2" /></xsl:element>
              <xsl:element name="p"><xsl:value-of select="resume/person/firstname" /></xsl:element>
              <xsl:for-each select="./resume/addresses/address">
                <xsl:apply-templates />
              </xsl:for-each>

            </xsl:element>
          </xsl:element>
        </xsl:template>

        <xsl:template match="para">
          <xsl:element name="p">
            <xsl:value-of select="." />
          </xsl:element>
        </xsl:template>
</xsl:stylesheet>
