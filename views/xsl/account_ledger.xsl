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

<xsl:template match="/">


<div class="tableframe">
  <table class="journal-table">
    <thead>
      <tr>
        <th>
          <span class="i18n-date">Date</span>
        </th>
        <th>
          <span class="i18n-memo">Memorandum</span>
        </th>
        <th>
          <span class="i18n-debit">Amount</span>
        </th>
        <th>
          <span class="i18n-id">Balance</span>
        </th>
      </tr>
    </thead>
    <tbody>
      <xsl:for-each select="//transactions/transaction">
      <tr>
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
          <xsl:value-of select="@balance"/>
        </td>
      </tr>
      </xsl:for-each>
    </tbody>
</table>
</div>

</xsl:template>
</xsl:stylesheet>
