REGDEL
======

Summary
-------

Regdel is a double-entry accounting system written in Ruby, complete with
accounts, a general journal, general ledger, and account ledgers. It is mostly
based off of my experience writing PBooks, a double-entry system written in PHP.

Status
------

* November 2009: Alpha

Requirements
------------

* Ruby
* Sinatra
* DataMapper
* SQLite / MySQL
* Builder
* Nokogiri


Components
----------

* Data model is specified in XML, transformed into classes for use by DataMapper
by XSL
* Views are XML-based and built Ruby Builder
* User interface is rendered via XHTML and XSL by Nokogiri or NGINX


Notes
-----

<pre>
INSERT INTO accounts (name) VALUES ('test');
</pre>
