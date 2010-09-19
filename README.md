OpenCoinage Wallet
==================

This is the [OpenCoinage.org][OpenCoinage] reference implementation of an
eletronic wallet for digital cash. It includes two programs:

* `ocw` is a [CLI][] application for power users.
* `ocwqt` is a [GUI][] application using the [Qt][] cross-platform UI
  framework.

_Note: this is at present pre-alpha software, and is unlikely to be of much
interest to you. Check back later!_

Dependencies
------------

### Platform

The CLI application requires the [Ruby][] language runtime as well as the
[SQLite][] database engine, and runs on any platform supported by Ruby.

The GUI application requires in addition the [Qt4][Qt] framework and the
[QtRuby][] bindings. It runs on the Mac OS X, Linux, and Windows operating
systems, or on any other system satisfying these dependencies.

Download
--------

To get a local working copy of the development repository, do:

    $ git clone git://github.com/opencoinage/opencoinage-wallet.git

Alternatively, download the latest development version as a tarball as
follows:

    $ wget http://github.com/opencoinage/opencoinage-wallet/tarball/master

Installation
------------

The recommended installation method is via [RubyGems](http://rubygems.org/).
To install the latest official release of the application, do:

    $ sudo gem install opencoinage-wallet

If you haven't yet got [Qt][] and the [QtRuby][] bindings, you will need to
install them as well before you can make use of the GUI application. The CLI
application does not need these additional dependencies.

Uninstallation
--------------

Should you wish to remove the application from your system, do:

    $ sudo gem uninstall opencoinage-wallet

Environment
-----------

The following are the default settings for environment variables that let
you customize how the application works:

    $ export OPENCOINAGE_HOME=~/.opencoinage

Mailing List
------------

<http://groups.google.com/group/opencoinage>

Author
------

[Arto Bendiken](mailto:arto.bendiken@gmail.com) - <http://ar.to/>

Contributors
------------

Refer to the accompanying `CREDITS` file.

License
-------

This is free and unencumbered public domain software. For more information,
see <http://unlicense.org/> or the accompanying `UNLICENSE` file.

[OpenCoinage]: http://opencoinage.org/
[Ruby]:        http://ruby-lang.org/
[Qt]:          http://qt.nokia.com/
[QtRuby]:      http://en.wikipedia.org/wiki/QtRuby
[Qt bindings]: http://rubygems.org/gems/qtbindings
[SQLite]:      http://sqlite.org/
[CLI]:         http://en.wikipedia.org/wiki/Command-line_interface
[GUI]:         http://en.wikipedia.org/wiki/Graphical_user_interface
