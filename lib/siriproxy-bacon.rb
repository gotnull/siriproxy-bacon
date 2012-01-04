require 'cora'
require 'siri_objects'
require 'nokogiri'
require 'cgi'
require 'open-uri'

class SiriProxy::Plugin::Bacon < SiriProxy::Plugin

	def initialize(config = {})
		@the_oracle = "Kevin Bacon"
		@the_oracle_escaped = CGI::escape(@the_oracle)
	end

	def bacon_url(actor)
		uri = "http://oracleofbacon.org/cgi-bin/xml?a=#{@the_oracle_escaped}&b=#{CGI::escape(actor)}&u=1&p=google-apps"
		
		return uri
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
			r = r + actor.text.sub(/\s*\(.+\)$/, "").strip
			
			if (movies[movieIndex])
				r = r + (firstPerson ? "" : " who") + " was in #{movies[movieIndex].text.sub(/\s*\(.+\)$/, '')} with "
			end
			
			movieIndex += 1
			
			firstPerson = false
		end

		return r
	end

	# Example: "Kevin Bacon and Tom Cruise"
	listen_for /kevin bacon and (.+)/i do |actor|

		say "Oracle of Bacon, here we come!"

		Thread.new {
		
			results = "#{kb(actor)}."
			
			say results
		
			request_completed
		}

	end

end
