<!--
Program: http://www.regdel.com
Component: html_custom.xsl
Copyright: Savonix Corporation
Author: Albert L. Lash, IV
License: Gnu Affero Public License version 3
http://www.gnu.org/licenses

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program; if not, see http://www.gnu.org/licenses
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml">

<xsl:strip-space elements="*"/>
<xsl:preserve-space elements="pre,td,br"/>

<xsl:template name="page">
  <html>
    <xsl:call-template name="head"/>
    <body>
      <xsl:if test="$USE_HTML_PARTIALS='1'">
        <xsl:apply-templates select="document('html/header.html')/*"/>
      </xsl:if>
      <div id="container"> 
        <div class="wat-cf" id="wrapper"> 
          <xsl:apply-templates select="//xhtml:body/*" />
          <xsl:apply-templates select="//div[@class='flash']" />
          <div id="main">
            <xsl:apply-templates select="//div[@id='main']/*" />
            <xsl:if test="$USE_HTML_PARTIALS='1'">
              <xsl:apply-templates select="document('html/footer.html')/*"/>
            </xsl:if>
          </div>
        </div>
      </div>
    </body>
    <xsl:if test="$RACK_ENV='demo'">
      <xsl:call-template name="analytics_code"/>
    </xsl:if>
  </html>
</xsl:template>

<xsl:template name="head">
  <head>
    <title>
      <xsl:value-of select="//h2" />
    </title>
    <xsl:if test="$USE_HTML_PARTIALS='0'">
      <xsl:apply-templates select="//head/*" />
    </xsl:if>
    <xsl:if test="$USE_HTML_PARTIALS='1'">
      <xsl:apply-templates select="document('html/head.html')/*"/>
    </xsl:if>
  </head>
</xsl:template>

<xsl:template match="span[contains(@class,'i18n')]">
  <xsl:value-of select="."/>
</xsl:template>
<xsl:template match="a[contains(@class,'regdel-link')]/@href">
  <xsl:attribute name="href"><xsl:value-of select="$RACK_MOUNT_PATH"/><xsl:value-of select="."/></xsl:attribute>
</xsl:template>

<xsl:template name="analytics_code">
<script src="http://www.google-analytics.com/ga.js" type="text/javascript"></script> 
<script type="text/javascript"> 
try {
var pageTracker = _gat._getTracker("UA-9068589-50");
pageTracker._setCookiePath("/demo/");
 
pageTracker._trackPageview();
} catch(err) {}</script>
</xsl:template>
</xsl:stylesheet>
