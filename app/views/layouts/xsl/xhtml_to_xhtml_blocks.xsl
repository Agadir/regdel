<!--
Program: http://www.regdel.com
Component: xhtml_to_xhtml_blocks.xsl
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
>
<xsl:import href="./app/views/layouts/xsl/1bb02b59/standard.xsl"/>
<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
<xsl:template match="/">
<div class="block">
  <div class="hd">
    <h2>
      <xsl:value-of select="$h2_title"/>
    </h2>
    </div>
    <div class="bd">
    <xsl:apply-templates />
    <div class="clear"></div>
  </div>
</div>
</xsl:template>

<xsl:template match="h2">
<xsl:element name="hr" />
<xsl:element name="h2">
<xsl:apply-templates />
</xsl:element>
</xsl:template>

</xsl:stylesheet>
