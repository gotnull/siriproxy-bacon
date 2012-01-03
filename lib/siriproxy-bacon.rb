require 'cora'
require 'siri_objects'
require 'nokogiri'

class SiriProxy::Plugin::Bacon < SiriProxy::Plugin

	def initialize(config = {})
	end

	def kb(to)
		
		uri = "http://oracleofbacon.org/cgi-bin/xml?a=Kevin%20Bacon&b=#{to.strip.gsub(" ", "%20")}&u=1&p=google-apps"
		doc = Nokogiri::XML(open(uri))
		
		return parse(doc)
	end

	def parse(doc)
		
		attr = doc.xpath("//link//actor").first # => "<actor>Tom Cruise</actor>"
		
		if (!attr)
			return "Cannot find actor."
		end

		actors = doc.xpath("//link//actor")
		movies = doc.xpath("//link//movie")
		
		if (!actors || actors.length == 0)
			return "No match found."
		end

		movieIndex = 0
		r = ""
		firstPerson = true
		
		actors.each do |actor|
			r = r + actor.text.strip
			
			if (movies[movieIndex])
				r = r + (firstPerson ? "" : " who") + " was in #{movies[movieIndex].text.sub(/\s*\(.+\)$/, '')} with "
			end
			
			movieIndex += 1
			
			firstPerson = false
		end

		return r
	end

	# Example: "Kevin Bacon and Tom Cruise?"
	listen_for /kevin bacon and (.+)/i do |actor|

		say "Oracle of Bacon, here we come!"

		Thread.new {
		
			results = "#{kb(actor)}."
			
			say results
		
			request_completed
		}

	end

end
