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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">


<div class="block"><div class="bd">
<h3>Journal Entries</h3>
<table id="journal-table">
  <thead>
    <tr>
      <th>
        <span class="i18n-date">Date</span>
      </th>
      <th width="200">
        <span class="i18n-memo">Memorandum</span>
      </th>
      <th>
        <span class="i18n-amount">Amount</span>
      </th>
      <th>
        <span class="i18n-id">ID</span>
      </th>
    </tr>
  </thead>
  <tbody id="journal-table-entries">
    <xsl:for-each select="//entries/entry">
    <tr class="entry_row" id="{@id}">
      <td class="reldate">
        <xsl:value-of select="@date"/>
      </td>
      <td>
        <xsl:value-of select="@memorandum"/>
      </td>
      <td>
        <xsl:value-of select="@amount"/>
      </td>
      <td>
        <xsl:value-of select="@id"/>
      </td>
    </tr>
    </xsl:for-each>
  </tbody>
</table>
<span id="table_controls">
<a href="./{//entries/@prev}">Prev</a>
<a href="/entry/new">New</a>
<a href="./{//entries/@next}">Next</a>
</span>
<span id="table_meta"></span>
</div></div>
</xsl:template>
</xsl:stylesheet>
