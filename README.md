[REGDEL](http://www.regdel.com/)
========

Summary
-------

Regdel is a double-entry accounting system written in Ruby, complete with
accounts, a general journal, general ledger, and account ledgers. It is mostly
based off of my experience writing PBooks, a double-entry system written in PHP.

Quick Start
-----------

<pre>
git clone git://github.com/docunext/regdel.git
cd regdel
git submodule init
git submodule update
ruby regdel.rb
</pre>


Status
------

* January 2010: Alpha

Requirements
------------

* Ruby
* Sinatra
* Rack-XSLView
* DataMapper
* SQLite / MySQL
* Builder, Sass, Yui-App-Theme
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


License
-------

Affero GPL
