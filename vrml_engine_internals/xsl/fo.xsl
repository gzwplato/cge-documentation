<?xml version='1.0'?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">
<xsl:import
  href="/usr/share/sgml/docbook/stylesheet/xsl/nwalsh/fo/docbook.xsl"/>

<xsl:import href="common.xsl"/>

<!-- Do not show Polish titlepage anymore. Our <colophon> mentions
     that it was originally my master's thesis, with some details
     and link to the original PDF version at http://www.ii.uni.wroc.pl/~anl/MGR/.
     So no point in this Polish page anymore. -->
<!-- <xsl:include href="fo-titlepage/mytitlepage.xsl"/> -->

<xsl:param name="admon.graphics" select="1"/>
<xsl:param name="admon.graphics.path">/usr/share/xml/docbook/stylesheet/nwalsh/images/</xsl:param>
<xsl:param name="admon.graphics.extension" select="'.svg'"></xsl:param>

<xsl:param name="paper.type" select="'A4'"></xsl:param>
<xsl:param name="body.font.master">11</xsl:param>

<!-- xsl:param name="ulink.show" select="0"></xsl:param> -->
<xsl:param name="ulink.hyphenate">&#x200B;</xsl:param>

<xsl:param name="ulink.hyphenate.chars" select="'/.'"></xsl:param>

<!-- Make page break in FO on <?page-break?> in DocBook source.
  Based on [http://sourceware.org/ml/docbook-apps/2003-q1/msg01210.html] -->
<xsl:template match="processing-instruction('page-break')">
  <fo:block break-after="page"/>
</xsl:template>

<xsl:param name="shade.verbatim" select="1"></xsl:param>

<!-- Make font for <screen> in PDF a little smaller.
  Based on [http://www.dpawson.co.uk/docbook/styling/fo.html],
  question 16. -->
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
  Based on
  [http://www.sagehill.net/docbookxsl/CustomXrefs.html#CustomXrefStyle]. -->
<xsl:attribute-set name="xref.properties">
  <xsl:attribute name="color">blue</xsl:attribute>
  <!--
  <xsl:attribute name="color">
    <xsl:choose>
      <xsl:when test="self::ulink">blue</xsl:when>
      <xsl:otherwise>inherit</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
  -->
</xsl:attribute-set>

<!-- Make line break on <?lb?> in DocBook source.
  From [http://sourceware.org/ml/docbook/2004-04/msg00031.html]
  which is based on DocBook Def Guide -->
<xsl:template match="processing-instruction('lb')">
  <fo:block>
    <xsl:text> </xsl:text>
  </fo:block>
</xsl:template>

<!-- Insert alpha character with appropriate font-family
  (otherwise it's not visible in PDF output).
  The suggestion from this comes from fop FAQ, see also
  [http://xmlgraphics.apache.org/fop/fo/fonts.fo.pdf].

  font-style="normal" is needed because I use this within
  phrase role="math" where normally I have italic font,
  and Symbol font family doesn't have an italic version. -->
<xsl:template match="processing-instruction('alpha')">
  <fo:inline font-family="Symbol" font-style="normal">&#x03B1;</fo:inline>
</xsl:template>

<!-- This makes variablelist and glosslist (we use variablelist
  to list VRML field types, glosslist to list some VRML features)
  look better.

  This also workarounds FOP footnotes bug (footnotes from lists do not
  work, but from normal blocks (as the one produced with
  variablelist.as.blocks) work OK). -->
<xsl:param name="variablelist.as.blocks">1</xsl:param>
<xsl:param name="glosslist.as.blocks">1</xsl:param>

<xsl:template match="phrase[@role= 'polish-characters']">
  <fo:inline font-family="DejaVuSerif">
    <xsl:apply-templates/>
  </fo:inline>
</xsl:template>

</xsl:stylesheet>
