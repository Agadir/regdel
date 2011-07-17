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

<xsl:strip-space elements="*"/>
<xsl:preserve-space elements="pre,td,br"/>

<xsl:template name="page">
  <html>
    <xsl:call-template name="head"/>
    <body class="rounded">
    <div id="doc3" class="yui-t6">
      <div id="hd">
        <h1>Regdel</h1>
        <div id="navigation">
        <ul id="primary-navigation">
          <li id="nav-home"><a class="regdel-link" href="/">Home</a></li>
          <li id="nav-journal"><a class="regdel-link" href="/entries">Journal</a></li>
          <li id="nav-transfer-funds"><a id="nav-entry-link" class="regdel-link" href="/entries/transfer_funds">Transfer Funds</a></li>
          <li id="nav-write-check"><a id="nav-entry-link" class="regdel-link" href="/entries/write_check">Write Check</a></li>
          <li id="nav-invoice"><a id="nav-invoice-link" class="regdel-link" href="/entries/write_check">Create Invoice</a></li>
          <li id="nav-accounts"><a class="regdel-link" href="/accounts">Accounts</a></li>
          <li id="nav-account"><a class="regdel-link" href="/accounts/new">New Account</a></li>
        </ul>
        <ul id="user-navigation">
          <li><a href="/regdel/runtime/info" class="regdel-link">Settings</a></li>
          <li><a href="/regdel/runtime/info" class="regdel-link not-production">Development</a></li>
        </ul>
        <div class="clear"></div>
        </div>
      </div>
      <div id="bd">
        <div id="yui-main">
          <div class="yui-b"><div class="yui-g">
            <div id="page-content">
            <xsl:if test="$RACK_ENV='demo'">
            </xsl:if>
            <xsl:apply-templates />
            </div>
          </div></div>
        </div>
        <div id="sidebar" class="yui-b">
        </div>
      </div>
    </div>
    <xsl:if test="$RACK_ENV='demo'">
      <xsl:call-template name="analytics_code"/>
    </xsl:if>
    </body>
  </html>
</xsl:template>

<xsl:template name="head">
  <head>
    <title>
      <xsl:value-of select="//h2" />
    </title>
    <xsl:if test="$RACK_ENV='demo'">
    <script type="text/javascript" src="http://www-01.evenserver.com/s/js/jquery/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="http://www-01.evenserver.com/s/js/jquery/plugins/jquery.url-1.0.js"></script>
    <script type="text/javascript" src="http://www-01.evenserver.com/s/js/jquery/plugins/jquery.jselect-1.3.1.js"></script>
    </xsl:if>
    <xsl:if test="not($RACK_ENV='demo')">
    <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/jquery/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/jquery/plugins/jquery.url.js"></script>
    <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/jquery/plugins/jquery.jselect.js"></script>
    </xsl:if>
    <link rel="stylesheet" href="http://yui.yahooapis.com/2.7.0/build/reset-fonts-grids/reset-fonts-grids.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="{$RACK_MOUNT_PATH}/s/css/pkgs/yui-app-theme/css/yuiapp.css"/>
    <link rel="stylesheet" type="text/css" href="{$RACK_MOUNT_PATH}/s/css/pkgs/yui-app-theme/css/yuiapp-layouts.css"/>
    <link rel="stylesheet" type="text/css" href="{$RACK_MOUNT_PATH}/s/css/pkgs/yui-app-theme/css/red.css"/>
    <script type="text/javascript">
    var app_prefix = '<xsl:value-of select="$RACK_MOUNT_PATH"/>';
    // These global variables are also used in account_form.js and entry_form.js
    var thisurl = jQuery.url.attr("source");
    var fixturl = thisurl.replace(app_prefix,'');
    </script>
    <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/regdel.js"></script>
    <xsl:if test="$PATH_INFO='/s/xhtml/account_form.html'">
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/account_form.js"></script>
    </xsl:if>
    <xsl:if test="contains($PATH_INFO,'/ledger') or $PATH_INFO='/s/xhtml/ledger.html'">
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/pkgs/tablesorter/addons/pager/jquery.tablesorter.pager.js"></script>
      <link rel="stylesheet" href="{$RACK_MOUNT_PATH}/s/js/pkgs/jquery-tablesorter-app-theme/style.css" type="text/css" media="print, projection, screen" /> 
      <link rel="stylesheet" href="{$RACK_MOUNT_PATH}/s/js/pkgs/tablesorter/addons/pager/jquery.tablesorter.pager.css" type="text/css" media="print, projection, screen" />
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/ledger.js"></script>
    </xsl:if>
    <xsl:if test="$PATH_INFO='/s/xhtml/welcome.html' or $PATH_INFO='/'">
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/welcome.js"></script>
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/pkgs/shjs/shjs-0.6/sh_main.min.js"></script>
      <link rel="stylesheet" href="{$RACK_MOUNT_PATH}/s/js/pkgs/shjs/shjs-0.6/css/sh_vim-dark.min.css" />
    </xsl:if>
    <xsl:if test="$PATH_INFO='/s/xhtml/entry_all_form.html'">
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/jquery/plugins/jquery.calculation.js"></script>
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/pkgs/jquery.autocomplete/jquery.autocomplete.js"></script>
      <link rel="stylesheet" href="{$RACK_MOUNT_PATH}/s/js/pkgs/jquery.autocomplete/jquery.autocomplete.css" type="text/css" />
      <link rel="stylesheet" href="{$RACK_MOUNT_PATH}/s/js/pkgs/datepicker/datePicker.css" type="text/css" media="screen" />
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/jquery/plugins/jquery.date.js"></script>
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/pkgs/datepicker/jquery.datePicker.js"></script>
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/pkgs/jquery-validate/jquery.validate.min.js"></script>
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/entry_form.js"></script>
    </xsl:if>
    <xsl:if test="contains($PATH_INFO,'/accounts')">
      <link rel="stylesheet" href="{$RACK_MOUNT_PATH}/s/js/pkgs/jquery-tablesorter-app-theme/style.css" type="text/css" media="print, projection, screen" />
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/accounts.js"></script>
    </xsl:if>
    <xsl:if test="contains($PATH_INFO,'/journal')">
      <link rel="stylesheet" href="{$RACK_MOUNT_PATH}/s/js/pkgs/jquery-tablesorter-app-theme/style.css" type="text/css" media="print, projection, screen" />
      <script type="text/javascript" src="{$RACK_MOUNT_PATH}/s/js/journal.js"></script>
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
