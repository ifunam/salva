<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
<xsl:element name="html">
        <xsl:element name="head">
 	       <xsl:element name="title">Curriculum</xsl:element>
	</xsl:element>
	<xsl:element name="body">
        	<xsl:for-each select="./resume">
			<xsl:apply-templates />
	        </xsl:for-each>
	</xsl:element>
</xsl:element>
</xsl:template>

<xsl:template match="PERSON">
<xsl:element name="span"><b>Nombre:</b>	<xsl:value-of select="resume/person/lastname1" /> 
                                        <xsl:value-of select="resume/person/lastname2" />
				        <xsl:value-of select="resume/person/firstname" />
</xsl:element>

* Datos personales (person y address)

* Experiencia laboral

* No. de citas

* Líneas y áreas de investigación

* Proyectos

* Publicaciones
  - book
  - chapterinbook
  - articles
  - proceeding
  - inproceeding
  - techreport
  - ... (Ver bibtex e identificar cuales tipos son los que usamos)

* Actividades y productos de divulgación
  - productos
  - actividades
  - misc

* Actividades y productos de extensión
  - productos
  - actividades
  - misc

* Actividades y productos de docencia
  - productos
  - actividades
  - misc

<xsl:template match="MISC">
</xsl:template>
</xsl:stylesheet>
