<?xml version='1.0'?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">
<xsl:import
  href="/usr/share/sgml/docbook/stylesheet/xsl/nwalsh/fo/docbook.xsl"/>

<xsl:import href="common.xsl"/>

<!-- Our titlepage customization -->
<xsl:include href="fo-titlepage/mytitlepage.xsl"/>

<xsl:param name="admon.graphics" select="1"/>
<xsl:param name="admon.graphics.path">/usr/share/xml/docbook/stylesheet/nwalsh/images/</xsl:param>
<xsl:param name="admon.graphics.extension" select="'.svg'"></xsl:param>

<xsl:param name="ulink.hyphenate">&#x200B;</xsl:param>
<xsl:param name="ulink.hyphenate.chars" select="'/.'"></xsl:param>

<xsl:param name="shade.verbatim" select="1"></xsl:param>

<!-- Make font for <screen> in PDF a little smaller.
     Based on [http://www.dpawson.co.uk/docbook/styling/fo.html], question 16. -->
<xsl:attribute-set name="monospace.verbatim.properties"
  use-attribute-sets="verbatim.properties">
  <xsl:attribute name="font-family">
    <xsl:value-of select="$monospace.font.family"/>
  </xsl:attribute>
  <xsl:attribute name="font-size">
    <xsl:value-of select="$body.font.master * 0.9"/>
    <xsl:text>pt</xsl:text>
  </xsl:attribute>
</xsl:attribute-set>

<!-- Make all links in FO output blue.
     Based on [http://www.sagehill.net/docbookxsl/CustomXrefs.html#CustomXrefStyle]. -->
<xsl:attribute-set name="xref.properties">
  <xsl:attribute name="color">blue</xsl:attribute>
</xsl:attribute-set>

<xsl:template match="phrase[@role='underline']">
  <fo:inline text-decoration="underline">
    <xsl:apply-templates/>
  </fo:inline>
</xsl:template>

<!-- Make <phrase role="italic"> work as italic.
     Sometimes <emphasis> doesn't work for this, it tries to be too smart
     when it's inside <emphasis role="bold"> for FO output. -->
<xsl:template match="phrase[@role='italic']">
  <fo:inline font-style="italic">
    <xsl:apply-templates/>
  </fo:inline>
</xsl:template>

<!-- Make <phrase role="symbol"> use the symbol font, that has some
     special characters. Also force font-style="normal",
     because I often use this inside italic text,
     and Symbol font family doesn't have an italic version
     (causes some warnings from FOP). -->
<xsl:template match="phrase[@role='symbol']">
  <fo:inline font-family="MySymbol" font-style="normal">
    <xsl:apply-templates/>
  </fo:inline>
</xsl:template>

<!-- Set slightly lighter background on <screen> (default is E0E0E0)
     and add border. -->
<xsl:attribute-set name="shade.verbatim.style">
  <xsl:attribute name="background-color">#FAFAFA</xsl:attribute>
  <xsl:attribute name="border">0.5pt solid black</xsl:attribute>
  <xsl:attribute name="padding">0.05in</xsl:attribute>
</xsl:attribute-set>

<!-- Without this, tables in FO have internal frames, even when frame="none"
     was used. -->
<xsl:param name="table.cell.border.style">none</xsl:param>

<xsl:param name="callout.graphics.path">/usr/share/xml/docbook/stylesheet/nwalsh/images/callouts/</xsl:param>

<xsl:param name="paper.type" select="'A4'"></xsl:param>
<xsl:param name="body.font.master">11</xsl:param>

<!-- By default, normal text is indented to the left. This looks...
     interesting, but I prefer normal look. -->
<xsl:param name="body.start.indent">0pt</xsl:param>
<xsl:param name="title.margin.left">0pt</xsl:param>

<!-- Surround <abbrev> (but only inside the bibliography list,
     not in xrefs to bibliography entries) in bold.
     This template comes from
     /usr/share/sgml/docbook/stylesheet/xsl/nwalsh/fo/biblio.xsl,
     it's also simplified since we know we always use abbrev for label. -->
<xsl:template name="biblioentry.label">
  <xsl:param name="node" select="."/>
  <fo:inline font-weight="bold">
    <xsl:text>[</xsl:text>
    <xsl:apply-templates select="$node/abbrev[1]"/>
    <xsl:text>] </xsl:text>
  </fo:inline>
</xsl:template>

<!-- Make hard page break in FO on <?page-break?> in DocBook source.
  Based on [http://sourceware.org/ml/docbook-apps/2003-q1/msg01210.html]
  and [http://www.sagehill.net/docbookxsl/PageBreaking.html].

  Unfortunately, soft page breaks by <?dbfo-need height="1in" ?>
  still don't work with FOP. -->
<xsl:template match="processing-instruction('page-break')">
  <fo:block break-after="page"/>
</xsl:template>

<!-- Use our custom fonts, to have all fonts embedded in PDF.
     The font family names correspond to names in ../fop/fonts/fop_config.xml. -->
<xsl:param name="body.font.family">MySerif</xsl:param>
<xsl:param name="dingbat.font.family">MySerif</xsl:param>
<xsl:param name="monospace.font.family">MyMonospace</xsl:param>
<xsl:param name="sans.font.family">MySans</xsl:param>
<xsl:param name="title.font.family">MySans</xsl:param>
<xsl:param name="symbol.font.family">MySymbol</xsl:param>

</xsl:stylesheet>
