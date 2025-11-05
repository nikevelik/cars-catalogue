<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

  <!-- Root template -->
  <xsl:template match="/catalog">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4"
                               page-height="29.7cm"
                               page-width="21cm"
                               margin-top="2cm"
                               margin-bottom="2cm"
                               margin-left="2cm"
                               margin-right="2cm">
          <fo:region-body/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="A4">
        <fo:flow flow-name="xsl-region-body">

          <fo:block font-size="18pt" font-weight="bold" space-after="10pt">Car Catalog</fo:block>

          <!-- Brands Table -->
          <fo:block font-size="14pt" font-weight="bold" space-before="10pt" space-after="5pt">Brands</fo:block>
          <fo:table table-layout="fixed" width="50%" border="0.5pt solid black" border-collapse="collapse">
            <fo:table-column column-width="100%"/>
            <fo:table-header>
              <fo:table-row background-color="#CCCCCC">
                <fo:table-cell><fo:block>Brand Name</fo:block></fo:table-cell>
              </fo:table-row>
            </fo:table-header>
            <fo:table-body>
              <xsl:for-each select="brands/brand">
                <fo:table-row>
                  <fo:table-cell><fo:block><xsl:value-of select="name"/></fo:block></fo:table-cell>
                </fo:table-row>
              </xsl:for-each>
            </fo:table-body>
          </fo:table>

          <!-- Models Table -->
          <fo:block font-size="14pt" font-weight="bold" space-before="10pt" space-after="5pt">Models</fo:block>
          <fo:table table-layout="fixed" width="100%" border="0.5pt solid black" border-collapse="collapse">
            <fo:table-column column-width="40%"/>
            <fo:table-column column-width="60%"/>
            <fo:table-header>
              <fo:table-row background-color="#CCCCCC">
                <fo:table-cell><fo:block>Model Name</fo:block></fo:table-cell>
                <fo:table-cell><fo:block>Brand Name</fo:block></fo:table-cell>
              </fo:table-row>
            </fo:table-header>
            <fo:table-body>
              <xsl:for-each select="models/model">
                <fo:table-row>
                  <fo:table-cell><fo:block><xsl:value-of select="name"/></fo:block></fo:table-cell>
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="/catalog/brands/brand[@id = current()/@brandRef]/name"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </xsl:for-each>
            </fo:table-body>
          </fo:table>

          <!-- Engines Table -->
          <fo:block font-size="14pt" font-weight="bold" space-before="10pt" space-after="5pt">Engines</fo:block>
          <fo:table table-layout="fixed" width="100%" border="0.5pt solid black" border-collapse="collapse">
            <fo:table-column column-width="40%"/>
            <fo:table-column column-width="30%"/>
            <fo:table-column column-width="30%"/>
            <fo:table-header>
              <fo:table-row background-color="#CCCCCC">
                <fo:table-cell><fo:block>Engine Name</fo:block></fo:table-cell>
                <fo:table-cell><fo:block>Model Name</fo:block></fo:table-cell>
                <fo:table-cell><fo:block>Power</fo:block></fo:table-cell>
              </fo:table-row>
            </fo:table-header>
            <fo:table-body>
              <xsl:for-each select="engines/engine">
                <fo:table-row>
                  <fo:table-cell><fo:block><xsl:value-of select="name"/></fo:block></fo:table-cell>
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="/catalog/models/model[@id = current()/@modelRef]/name"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell><fo:block><xsl:value-of select="power"/></fo:block></fo:table-cell>
                </fo:table-row>
              </xsl:for-each>
            </fo:table-body>
          </fo:table>

          <!-- Cars -->
          <fo:block font-size="14pt" font-weight="bold" space-before="10pt" space-after="5pt">Cars</fo:block>
          <xsl:for-each select="cars/car">
            <fo:block border="0.5pt solid black" padding="5pt" margin-bottom="5pt">
              <xsl:variable name="model" select="/catalog/models/model[@id = current()/@modelRef]"/>
              <xsl:variable name="engine" select="/catalog/engines/engine[@id = current()/@engineRef]"/>
              <xsl:variable name="brand" select="/catalog/brands/brand[@id = $model/@brandRef]"/>

              <fo:block><fo:inline font-weight="bold">Brand:</fo:inline> <xsl:value-of select="$brand/name"/></fo:block>
              <fo:block><fo:inline font-weight="bold">Model:</fo:inline> <xsl:value-of select="$model/name"/></fo:block>
              <fo:block><fo:inline font-weight="bold">Engine:</fo:inline> <xsl:value-of select="$engine/name"/> (<xsl:value-of select="$engine/power"/>)</fo:block>
              <fo:block><fo:inline font-weight="bold">Price:</fo:inline> $<xsl:value-of select="price"/></fo:block>
              <fo:block><fo:inline font-weight="bold">Description:</fo:inline> <xsl:value-of select="description"/></fo:block>
              <fo:block><fo:inline font-weight="bold">Color:</fo:inline> <xsl:value-of select="color/@value"/></fo:block>
              <fo:block><fo:inline font-weight="bold">Transmission:</fo:inline> <xsl:value-of select="transmission/@type"/></fo:block>
              <fo:block><fo:inline font-weight="bold">Category:</fo:inline> <xsl:value-of select="category/@type"/></fo:block>
              <fo:block><fo:inline font-weight="bold">Year:</fo:inline> <xsl:value-of select="year"/></fo:block>
            </fo:block>
          </xsl:for-each>

        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

</xsl:stylesheet>
