Oracle of Bacon, Siri style!
============================

This is a plugin for SiriProxy that replicates the functionality at http://www.oracleofbacon.org

History
-------

Six Degrees of Kevin Bacon is a trivia game based on the concept of the small world phenomenon and rests on the assumption that any individual involved in the Hollywood, California film industry can be linked through his or her film roles to actor Kevin Bacon within six steps. The name of the game is a play on the "six degrees of separation" concept. The game requires a group of players to try to connect any individual to Kevin Bacon as quickly as possible and in as few links as possible. In 2007, Bacon started a charitable organization named SixDegrees.org.

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
