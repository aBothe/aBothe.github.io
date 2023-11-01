<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:atom="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
    <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:key name="category" match="/rss/channel/item/category/text()" use="." />

    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>
                    <xsl:value-of select="/rss/channel/title"/>
                </title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
                <link rel="stylesheet" href="blog.css"/>
            </head>
            <body>
                <div class="head inner">
                    <xsl:if test="/rss/channel/image">
                        <a class="head_logo">
                            <xsl:attribute name="href">
                                <xsl:value-of select="/rss/channel/link"/>
                            </xsl:attribute>
                            <img>
                                <xsl:attribute name="src">
                                    <xsl:value-of select="/rss/channel/image/url"/>
                                </xsl:attribute>
                                <xsl:attribute name="title">
                                    <xsl:value-of select="/rss/channel/title"/>
                                </xsl:attribute>
                            </img>
                        </a>
                    </xsl:if>
                    <div class="head_main">
                        <h1>
                            <xsl:value-of select="/rss/channel/title"/>
                        </h1>
                        <p>
                            <xsl:apply-templates select="/rss/channel/description"/>
                        </p>
                        <!--<div class="head_topics">
                            Topics:
                        <xsl:for-each select="/rss/channel/item/category/text()[generate-id()
                                       = generate-id(key('category',.)[1])]">
                            <xsl:sort select="."/>
                            <a class="head_link">
                                <xsl:attribute name="href">
                                    <xsl:text>?topic=</xsl:text>
                                    <xsl:value-of select="."/>
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                                <xsl:if test="position() != last()">, </xsl:if>
                            </a>
                        </xsl:for-each>
                        </div>-->
                    </div>
                </div>
                <xsl:if test="/rss/channel/atom:link[@rel='alternate']">
                    <div class="links inner">
                        <xsl:for-each select="/rss/channel/atom:link[@rel='alternate']">
                            <a target="_blank">
                                <xsl:attribute name="class">
                                    <xsl:value-of select="@icon"/>
                                </xsl:attribute>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="@href"/>
                                </xsl:attribute>
                                <xsl:value-of select="@title"/>
                            </a>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                <xsl:for-each select="/rss/channel/item">
                    <div class="item inner">
                        <div class="item_meta">
                            <span>
                                <xsl:value-of select="pubDate"/>
                            </span>
                        </div>
                        <h2>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:text>#</xsl:text>
                                    <xsl:value-of select="guid"/>
                                </xsl:attribute>
                                <xsl:attribute name="id">
                                    <xsl:value-of select="guid"/>
                                </xsl:attribute>
                                <xsl:value-of select="title"/>
                            </a>
                        </h2>
                        <article>
                            <xsl:apply-templates select="description"/>
                        </article>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="description">
        <xsl:copy-of select="node()"/>
    </xsl:template>
</xsl:stylesheet>