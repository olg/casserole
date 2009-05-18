Casserole
=========

A Cocoa client for Chef, replicating in a native OS X experience functionality from the Chef Server Web UI.

<http://github.com/fotonauts/casserole>

<http://code.fotonauts.com/software/casserole>

<http://code.fotonauts.com/blog>


License
-------

Apache License v2, see LICENSE.txt file.

In this first version
---------------------


* *read-only* access to a chef server. Write access is not far away, but the priority for this initial release was UI polish
* Exploring nodes, registrations, cookbooks (no template content for now due to a REST API limitation).
* Access to the search indexes
* Live filtering / matching in node and search results.

Planned for next version
------------------------


* Saving search requests
* Read/Write support: changing attributes, tags and recipes
* Connecting to multiple chef servers
* MacRuby integration (testing cookbooks from Casserole ? pushing configs to the server ?)
* Support for the cookbooks role and metadata architecture when it's available
* Better integration with present and future Chef awesomeness

Requirements
------------


* Mac OS X 10.5
* A Chef Server installation somewhere (0.6.2 only)

Building from Source
--------------------

Open Casserole.xcodeproj and build, or use xcodebuild in command-line.

Bugs, suggestions
-----------------

Feel free to use the github issue tracker, or send email to <casserole@fotonauts.com>

Authors
-------

Olivier Gutknecht, Fotonauts - <olg@fotonauts.com>
