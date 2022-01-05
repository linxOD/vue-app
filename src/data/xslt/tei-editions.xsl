<xsl:transform
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:da="http://declarative.amsterdam/saxonjs"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    extension-element-prefixes="ixsl"
    expand-text="yes"
    version="3.0"
    >

    <!-- <xsl:import href="partials/osd-container.xsl"/>
    <xsl:import href="partials/tei-facsimile.xsl"/> -->

    <!-- <xsl:template match="/">
        <xsl:result-document href="http://localhost:8080/#/started#editions-input" method="ixsl:replace-content" expand-text="true">
            <xsl:apply-templates select="//tei:body" />
        </xsl:result-document>
    </xsl:template> -->

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@level='a'][1]/text()"/>
        </xsl:variable>
        <div class="card">
            <div class="card-header">
                <h1><xsl:value-of select="$doc_title"/></h1>
            </div>
            <div id="navBarLetters" style="margin-top:4em !important;">
                <ul class="nav nav-tabs" id="dropdown-lang">
                    <li class="nav-item">
                        <a title="Cards" href="#diplomatic-tab" data-toggle="tab" class="nav-link btn btn-round active">
                            diplomatic view
                        </a>
                    </li>
                    <li class="nav-item">
                        <a title="Table" href="#commentary-tab" data-toggle="tab" class="nav-link btn btn-round">
                            commentary view
                        </a>
                    </li>
                    <li class="nav-item">
                        <a title="Table" href="#reading-tab" data-toggle="tab" class="nav-link btn btn-round">
                            reading view
                        </a>
                    </li>
                </ul>
            </div>
            <div class="tab-content">
                <div class="tab-pane active" id="diplomatic-tab" tabindex="-1">
                    <div class="card-body">
                        <xsl:for-each select="//tei:div[@xml:id='transcription']">
                            <xsl:for-each-group select="*" group-starting-with="tei:pb">
                                <div class="transcript row" style="padding:0 1em;">
                                    <div class="col-md-6" style="padding:0!important;">
                                        <hr/>
                                        <div class="card-body">                                                                                                                                                                                       
                                        <xsl:for-each select="current-group()[self::tei:p]">
                                            <p>
                                                <xsl:apply-templates>
                                                    <xsl:with-param name="view" select="'diplomatic'"/>
                                                </xsl:apply-templates>
                                            </p>
                                        </xsl:for-each>
                                        </div>
                                    </div>
                                </div>
                            </xsl:for-each-group>
                        </xsl:for-each>
                    </div>
                </div>
                <div class="tab-pane fade" id="reading-tab" tabindex="-1">
                    <div class="card-body">
                        <xsl:for-each select="//tei:div[@xml:id='transcription']">
                            <xsl:for-each-group select="*" group-starting-with="tei:pb">
                                <hr/>
                                <xsl:for-each select="current-group()[self::tei:p]">
                                    <p class="yes-index">
                                        <xsl:apply-templates>
                                            <xsl:with-param name="view" select="'reading'"/>
                                        </xsl:apply-templates>
                                    </p>
                                </xsl:for-each>
                            </xsl:for-each-group>
                        </xsl:for-each>
                    </div>
                </div>
                <div class="tab-pane fade" id="commentary-tab" tabindex="-1">
                    <div class="card-body" style="padding:1em;">
                        <xsl:for-each select="//tei:div[@xml:id='transcription']">
                            <xsl:for-each-group select="*" group-starting-with="tei:pb">
                                <hr/>
                                <xsl:for-each select="current-group()[self::tei:p]">
                                    <p>
                                        <xsl:apply-templates>
                                            <xsl:with-param name="view" select="'commentary'"/>
                                        </xsl:apply-templates>
                                    </p>
                                </xsl:for-each>
                            </xsl:for-each-group>
                        </xsl:for-each>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:lb">
        <xsl:param name="view"/>
        <xsl:if test="$view = 'diplomatic' or $view = 'commentary'">
            <br/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <xsl:param name="view"/>
        <xsl:choose>
            <xsl:when test="$view = 'diplomatic' or $view = 'commentary'">
                <abbr title="unclear"><xsl:apply-templates/></abbr>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:del">
        <xsl:param name="view"/>
        <xsl:choose>
            <xsl:when test="$view = 'diplomatic' or $view = 'commentary' or $view = 'reading'">
                <del><xsl:apply-templates/></del>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:transform>

