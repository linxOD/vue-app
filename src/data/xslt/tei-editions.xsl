<xsl:transform
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:da="http://declarative.amsterdam/saxonjs"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all"
    extension-element-prefixes="ixsl"
    expand-text="yes"
    version="3.0"
    >

    <!-- <xsl:import href="partials/osd-container.xsl"/>
    <xsl:import href="partials/tei-facsimile.xsl"/> -->

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@level='a'][1]/text()"/>
        </xsl:variable>
        <div class="card">
            <div class="card-header">
                <h1><xsl:value-of select="$doc_title"/></h1>
            </div>
            <div class="card-body">
               <xsl:apply-templates select="//tei:body"/>
            </div>
        </div>
    </xsl:template>
</xsl:transform>
