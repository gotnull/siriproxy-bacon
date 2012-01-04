require 'cora'
require 'siri_objects'
require 'nokogiri'
require 'cgi'
require 'open-uri'

class SiriProxy::Plugin::Bacon < SiriProxy::Plugin

	def initialize(config = {})
		@the_oracle = "Kevin Bacon"
		@bacon_number = 0
		@the_oracle_escaped = CGI::escape(@the_oracle)
		@responses = [	"Cooking up some Bacon!",
				"Oracle of Bacon, here we come!",
				"Mmm, Bacon!",
				"Bacon this, bacon that!",
				"Want some Bacon?"	]
	end

	def bacon_url(actor)
		uri = "http://oracleofbacon.org/cgi-bin/xml?a=#{@the_oracle_escaped}&b=#{CGI::escape(actor)}&u=1&p=google-apps"
		
		return uri
	end

	def remove_parentheses(str)
		return str.sub(/\s*\(.+\)$/, "")
	end

	def kb(to)
		
		uri = bacon_url(to.strip)
		doc = Nokogiri::XML(open(uri))
		
		spellcheck = doc.xpath("//spellcheck/match").first
		
		if (spellcheck)
			uri = bacon_url(spellcheck.text.strip)
			doc = Nokogiri::XML(open(uri))
		end

		return parse(doc)
	end

	def parse(doc)
		
		attr = doc.xpath("//link//actor").first # => "<actor>Tom Cruise</actor>"
		
		if (!attr)
			return "Cannot find actor"
		end

		actors = doc.xpath("//link//actor")
		movies = doc.xpath("//link//movie")
		
		if (!actors || actors.length == 0)
			return "No match found"
		elsif (actors.first.text.include?(@the_oracle))
			return "#{@the_oracle}, is The Oracle"
		end

		movieIndex = 0
		r = ""
		firstPerson = true

		actors.each do |actor|
			r = r + remove_parentheses(actor.text).strip
			
			if (movies[movieIndex])
				r = r + (firstPerson ? "" : " who") + " was in #{remove_parentheses(movies[movieIndex].text)} with "
			end
			
			movieIndex += 1
			
			firstPerson = false
		end

		bacon_number(movieIndex)

		return r
	end

	def bacon_number(index)
		@bacon_number = (index - 1)
	end

	# Example: "Kevin Bacon and Tom Cruise"
	listen_for /kevin bacon and (.+)/i do |actor|

		say @responses[rand(@responses.size)]

		Thread.new {
		
			results = "#{kb(actor)}."
			
			say results
		
			request_completed
		}

	end

	# Example: "Bacon Number for Tom Cruise"
	listen_for /bacon number for (.+)/i do |actor|

		say @responses[rand(@responses.size)]

		Thread.new {
		
			kb(actor)
			
			say "#{actor} has a Bacon Number of #{@bacon_number}."
		
			request_completed
		}

	end

end
