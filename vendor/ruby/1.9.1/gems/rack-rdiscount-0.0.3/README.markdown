Summary
-------

Rack Middleware using RDiscount to transform and filter markdown content.


Status
------

This isn't done yet, but it functions.


Usage
-----

<pre class="sh_ruby">
use Rack::RackDiscount, :extension => 'mdwn'
</pre>

Note: extension option does nothing at the moment.

Legal
-----

Author: Albert Lash
Copyright: 2009, Savonix Corporation
License: MIT, BSD, GPL2, or GPL3

Thanks
------

* [Ryan Tomayko](http://tomayko.com/) for RDiscount 
* [David Parsons](http://www.pell.portland.or.us/~orc/) for Discount
* [John Gruber](http://daringfireball.net/) for Markdown
* <http://Github.com> for bridging mad gaps.