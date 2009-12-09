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


<xsl:template name="page">
  <html>
    <xsl:call-template name="head"/>
    <body class="rounded">
    <div id="doc3" class="yui-t6">
      <div id="hd">
      <h1>Regdel</h1>
      <div id="navigation">
        <xsl:apply-templates select="document('/var/www/dev/regdel/public/s/xhtml/nav_menu.html')/ul"/>
      </div>
      </div>
      <div id="bd">
      <div id="yui-main">
      <div class="yui-b">
      <div class="yui-g">
      <xsl:apply-templates />
      </div>
      </div>
      </div>
      </div>
      </div>
    </body>
  </html>
</xsl:template>

<xsl:template name="head">
  <head>
    <title>
      <xsl:value-of select="(//h1|//h2)[1]" />
    </title>
    <link rel="stylesheet" href="http://yui.yahooapis.com/2.7.0/build/reset-fonts-grids/reset-fonts-grids.css" type="text/css"/>
    <!--
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/combo?2.7.0/build/reset/reset-min.css"/>
    <link rel="stylesheet" type="text/css" href="/s/css/pkgs/web-app-theme/stylesheets/base.css"/>
    <link rel="stylesheet" type="text/css" href="/s/css/pkgs/web-app-theme/stylesheets/themes/blue/style.css"/>
    -->
    <link rel="stylesheet" type="text/css" href="/s/css/pkgs/yui-app-theme/css/yuiapp.css"/>
    <link rel="stylesheet" type="text/css" href="/s/css/pkgs/yui-app-theme/css/red.css"/>
    <!--
    <link rel="stylesheet" type="text/css" href="/stylesheet.css"/>
    -->
    <script src="http://yui.yahooapis.com/3.0.0pr2/build/yui/yui-min.js" type="text/javascript"></script> 
    <script type="text/javascript" src="/s/js/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="/s/js/regdel.js"></script>
    <xsl:if test="$my_path_info='/s/xhtml/account_form.html'">
      <script type="text/javascript" src="/s/js/account_form.js"></script>
    </xsl:if>
    <xsl:if test="$my_path_info='/ledger'">
      <script type="text/javascript" src="/s/js/ledger.js"></script>
    </xsl:if>
    <xsl:if test="$my_path_info='/s/xhtml/entry_all_form.html'">
    <!--
      <link rel="stylesheet" type="text/css" href="/journal_entry_form.css"/>
      -->
      <script type="text/javascript" src="/s/js/entry_form.js"></script>
      <script type="text/javascript" src="/s/js/jquery/plugins/jquery.calculation.js"></script>
    </xsl:if>
    <xsl:if test="contains($my_path_info,'/accounts')">
      <script type="text/javascript" src="/s/js/accounts.js"></script>
    </xsl:if>
    <xsl:if test="contains($my_path_info,'/journal')">
      <script type="text/javascript" src="/s/js/journal.js"></script>
    </xsl:if>
    <script type="text/javascript" src="/s/js/jquery/plugins/jquery.url.js"></script>
    <script type="text/javascript" src="/s/js/jquery/plugins/jquery.jselect.js"></script>
    <script type="text/javascript" src="/s/js/relative_date.js"></script>
  </head>
</xsl:template>

<xsl:template match="span[contains(@class,'i18n')]">
  <xsl:value-of select="."/>
</xsl:template>

</xsl:stylesheet>
