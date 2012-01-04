Oracle of Bacon, Siri style!
============================

This is a plugin for SiriProxy that replicates the functionality at http://www.oracleofbacon.org

History
-------

Six Degrees of Kevin Bacon is a trivia game based on the concept of the small world phenomenon and rests on the assumption that any individual involved in the Hollywood, California film industry can be linked through his or her film roles to actor Kevin Bacon within six steps. The name of the game is a play on the "six degrees of separation" concept. The game requires a group of players to try to connect any individual to Kevin Bacon as quickly as possible and in as few links as possible. In 2007, Bacon started a charitable organization named SixDegrees.org.

Bacon Numbers
-------------

The Bacon number of an actor or actress is the number of degrees of separation he or she has from Bacon, as defined by the game. This is an application of the Erdős number concept to the Hollywood movie industry. The higher the Bacon number, the farther away from Kevin Bacon the actor is.

The computation of a Bacon number for actor X is a "shortest path" algorithm:

    Kevin Bacon himself has a Bacon number of 0.
    Those actors who have worked directly with Kevin Bacon have a Bacon number of 1.
    If the lowest Bacon number of any actor with whom X has appeared in a movie is N, X's Bacon number is N + 1.

Here is an example, using Elvis Presley:

    Elvis Presley was in Change of Habit (1969) with Edward Asner
    Edward Asner was in JFK (1991) with Kevin Bacon

Therefore Asner has a Bacon number of 1, and Presley (who never appeared in a film with Bacon himself) has a Bacon number of 2.

As of 24 June 2011, the highest finite Bacon number reported by the Oracle of Bacon is 8.[7]

Because some people have both Bacon and Erdős numbers due to acting and publications, there are a rare few who have an Erdős–Bacon number, which is defined as the sum of a person's independent Erdős and Bacon numbers.

Undefined Bacon numbers
-----------------------

A small proportion of actors have an undefined Bacon number, meaning that they cannot be linked to Bacon in any number of connections at all. According to the Oracle of Bacon website approximately 12% of all actors cannot be linked to Bacon using its criteria, but this number is difficult to verify.

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
