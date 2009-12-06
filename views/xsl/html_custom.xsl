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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml">

<!-- HTML SHELL -->
<xsl:template match="/">
  <html>
    <xsl:call-template name="head"/>
    <body>
      <xsl:apply-templates select="document('/var/www/dev/regdel/public/s/xhtml/nav_menu.html')/div"/>
      <xsl:apply-templates />
    </body>
  </html>
</xsl:template>

<xsl:template name="head">
  <xsl:param name="link_prefix"/>
  <xsl:param name="path_prefix"/>
  <head>
    <title>
      <xsl:value-of select="(//h1|//h2)[1]" />
    </title>
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/combo?2.7.0/build/reset/reset-min.css"/>
    <link rel="stylesheet" type="text/css" href="/stylesheet.css"/>
    <script type="text/javascript" src="/s/js/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="/s/js/regdel.js"></script>
    <xsl:if test="$my_path_info='/s/xhtml/account_form.html'">
      <script type="text/javascript" src="/s/js/account_form.js"></script>
    </xsl:if>
    <xsl:if test="$my_path_info='/s/xhtml/entry_all_form.html'">
      <script type="text/javascript" src="/s/js/entry_form.js"></script>
    </xsl:if>
    <script type="text/javascript" src="/s/js/jquery/plugins/jquery.url.js"></script>
    <script type="text/javascript" src="/s/js/jquery/plugins/jquery.jselect.js"></script>
    <script type="text/javascript" src="/s/js/relative_date.js"></script>
  </head>
</xsl:template>

<!--
<xsl:template match="//tr[@class='credit-row']">
  <xsl:copy>
    <xsl:apply-templates />
  </xsl:copy>
</xsl:template>
-->

</xsl:stylesheet>
