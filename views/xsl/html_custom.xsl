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
        <xsl:apply-templates select="document('/var/www/dev/regdel/public/s/xhtml/nav_menu.html')/div"/>
      </div>
      <div id="bd">
        <div id="yui-main">
          <div class="yui-b"><div class="yui-g">
            <div id="page-content">
            <xsl:apply-templates />
            </div>
          </div></div>
        </div>
        <div id="sidebar" class="yui-b">
          <xsl:apply-templates select="document('/var/www/dev/regdel/public/s/xhtml/sidebar.html')/div"/>
        </div>
      </div>
      <xsl:apply-templates select="document('/var/www/dev/regdel/public/s/xhtml/footer.html')/div"/>
    </div>
    </body>
  </html>
</xsl:template>

<xsl:template name="head">
  <head>
    <title>
      <xsl:value-of select="//h2" />
    </title>
    <script type="text/javascript">var app_prefix = '<xsl:value-of select="$RACK_MOUNT_PATH"/>';</script>
    <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/jquery/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/regdel.js"></script>
    <xsl:if test="$PATH_INFO='/s/xhtml/account_form.html'">
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/account_form.js"></script>
    </xsl:if>
    <xsl:if test="$PATH_INFO='/ledger' or $PATH_INFO='/s/xhtml/ledger.html'">
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/ledger.js"></script>
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/pkgs/tablesorter/jquery.tablesorter.js"></script>
      <link rel="stylesheet" href="{$RACK_MOUNT_PATH}/s/js/pkgs/tablesorter/themes/jquery-tablesorter-app-theme/style.css" type="text/css" media="print, projection, screen" /> 
    </xsl:if>
    <xsl:if test="$PATH_INFO='/s/xhtml/entry_all_form.html'">
    <!--
      <link rel="stylesheet" type="text/css" href="/journal_entry_form.css"/>
      -->
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/entry_form.js"></script>
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/jquery/plugins/jquery.calculation.js"></script>
    </xsl:if>
    <xsl:if test="contains($PATH_INFO,'/accounts')">
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/accounts.js"></script>
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/pkgs/tablesorter/jquery.tablesorter.js"></script>
    </xsl:if>
    <xsl:if test="contains($PATH_INFO,'/journal')">
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/journal.js"></script>
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/pkgs/tablesorter/jquery.tablesorter.js"></script>
      <link rel="stylesheet" href="{$RACK_MOUNT_PATH}/s/js/pkgs/tablesorter/themes/jquery-tablesorter-app-theme/style.css" type="text/css" media="print, projection, screen" />
    </xsl:if>
    <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/jquery/plugins/jquery.url.js"></script>
    <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/jquery/plugins/jquery.jselect.js"></script>
    <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/relative_date.js"></script>
    <link rel="stylesheet" href="http://yui.yahooapis.com/2.7.0/build/reset-fonts-grids/reset-fonts-grids.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="{$RACK_MOUNT_PATH}/s/css/pkgs/yui-app-theme/css/yuiapp.css"/>
    <link rel="stylesheet" type="text/css" href="{$RACK_MOUNT_PATH}/s/css/pkgs/yui-app-theme/css/yuiapp-layouts.css"/>
    <link rel="stylesheet" type="text/css" href="{$RACK_MOUNT_PATH}/s/css/pkgs/yui-app-theme/css/red.css"/>
    <link rel="stylesheet" type="text/css" href="{$RACK_MOUNT_PATH}/stylesheet.css"/>
  </head>
</xsl:template>

<xsl:template match="span[contains(@class,'i18n')]">
  <xsl:value-of select="."/>
</xsl:template>
<xsl:template match="a[contains(@class,'regdel-link')]/@href">
  <xsl:attribute name="href"><xsl:value-of select="$RACK_MOUNT_PATH"/><xsl:value-of select="."/></xsl:attribute>
</xsl:template>

</xsl:stylesheet>
