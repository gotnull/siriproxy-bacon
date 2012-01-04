Oracle of Bacon, Siri style!
============================

This is a plugin for SiriProxy that replicates the functionality at http://www.oracleofbacon.org

Prerequisite Gems
-----------------

1. Nokogiri (`gem install nokogiri`)
2. OpenURI (`gem install open-uri`)

Setup
-----

1. Copy the contents of `config-info.yml` into your `~/.siriproxy/config.yml`.
2. rvmsudo siriproxy update.
3. Restart SiriProxy.

Usage
-----

**Say:** Kevin Bacon and *(actor name)*

Will return the relationship between the actor and Kevin Bacon!

e.g. `Kevin Bacon and Tom Cruise` returns the following:

Tom Cruise was in A Few Good Men with Kevin Bacon.
