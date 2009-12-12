<!--
Program: http://www.regdel.com
Component: entries.xsl
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

<div class="block"><div class="hd">
  <h2>
    <span class="i18n-journal_entries">Journal Entries</span>
  </h2>
  <div class="bd">
  <table id="journal-table">
    <thead>
      <tr>
        <th>
          <span class="i18n-date">Date</span>
        </th>
        <th />
        <th width="200">
          <span class="i18n-memo">Memorandum</span>
        </th>
        <th width="15" />
        <th>
          <span class="i18n-accounts">Accounts</span>
        </th>
        <th>
          <span class="i18n-debit">Debit</span>
        </th>
        <th>
          <span class="i18n-credit">Credit</span>
        </th>
        <th>
          <span class="i18n-id">ID</span>
        </th>
        <th />
      </tr>
    </thead>
    <tbody>
      <xsl:for-each select="//entries/entry">
      <tr>
        <td>
          <xsl:value-of select="@date"/>
        </td>
        <td />
        <td>
          <xsl:value-of select="@memorandum"/>
        </td>
        <td/>
        <td>
          <xsl:value-of select="/debit/@account"/>
        </td>
        <td>
          <xsl:value-of select="./debit/@amount"/>
        </td>
        <td>
          <xsl:value-of select="./credit/@amount"/>
        </td>
        <td>
          <xsl:value-of select="@id"/>
        </td>
        <td />
      </tr>
      </xsl:for-each>
    </tbody>
</table>
</div>
</div></div>

</xsl:template>
</xsl:stylesheet>
