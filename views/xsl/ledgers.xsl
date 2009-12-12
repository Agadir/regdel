<!--
Program: http://www.regdel.com
Component: ledgers.xsl
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
<div class="block">
  <div class="hd">
  <h2>
    <span id="i18n-ledger"><xsl:value-of select="//transactions/@ledger_label"/> Ledger</span>
  </h2>
  </div>
  <div class="bd">
  <xsl:apply-templates />
  </div>
</div>
</xsl:template>

<xsl:template match="//transactions[@ledger_type='general']">
  <table class="ledger-table">
  <thead>
    <tr>
      <th>
        <span class="i18n-date">Date</span>
      </th>
      <th>
        <span class="i18n-memo">Memorandum</span>
      </th>
      <th>
        <span class="i18n-accounts">Account</span>
      </th>
      <th>
        <span class="i18n-amount">Amount</span>
      </th>
    </tr>
  </thead>
  <tbody>
    <xsl:apply-templates />
    </tbody>
  </table>

</xsl:template>

<xsl:template match="//transactions[@ledger_type='general']/transaction">
  <tr>
    <td class="reldate">
      <xsl:value-of select="@date"/>
    </td>
    <td>
      <xsl:value-of select="@memorandum"/>
    </td>
    <td>
      <a href="/ledgers/account/{@account_id}">
        <xsl:value-of select="@account_name"/>
      </a>
    </td>
    <td>
      <xsl:value-of select="@amount"/>
    </td>
  </tr>
</xsl:template>



<xsl:template match="//transactions[@ledger_type='account']">
<table class="ledger-table">
  <thead>
    <tr>
      <th>
        <span class="i18n-date">Date</span>
      </th>
      <th>
        <span class="i18n-memo">Memorandum</span>
      </th>
      <th>
        <span class="i18n-amount">Amount</span>
      </th>
      <th>
        <span class="i18n-balance">Balance</span>
      </th>
    </tr>
  </thead>
  <tbody>
    <xsl:apply-templates />
  </tbody>
</table>

</xsl:template>
<xsl:template match="//transactions[@ledger_type='account']/transaction">
  <tr>
    <td>
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
</xsl:template>
</xsl:stylesheet>
