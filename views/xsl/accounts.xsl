<!--
Program: http://www.regdel.com
Component: html_main.xsl
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
<xsl:output method="xml" omit-xml-declaration="yes" />
<xsl:template match="/">
<table class="accounts">
<thead>
<tr>
<th><span class="i18n-account_name">Account Name</span></th>
<th><span class="i18n-account_balance">Account Balance</span></th>
<th><span class="i18n-account_type">Account Type</span></th>
</tr>
</thead>
<tbody>
<xsl:for-each select="//account">
<tr id="{@id}"><td>
<a href="/account/edit/{@id}"><xsl:value-of select="@name"/></a>
</td>
<td>
</td>
<td>
<xsl:value-of select="@type"/>
</td>
</tr>
</xsl:for-each>
</tbody>
</table>

</xsl:template>
</xsl:stylesheet>
