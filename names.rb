require 'rubygems'
require 'nokogiri'
require 'open-uri'
links = [
	"http://en.wikipedia.org/wiki/List_of_computer_scientists",
	"http://en.wikipedia.org/wiki/List_of_programmers",
	"http://en.wikipedia.org/wiki/List_of_pioneers_in_computer_science",
]

names = []
lengths = []

links.each do |link|
	page = Nokogiri::HTML(open(link))
	page.css("div#mw-content-text ul li a").each do |a|
		if a.text.length > 1
			names.push([a.text, a["href"]])
			lengths.push(a.text.length)
		end
	end
end

names = names[5..-5] # first few aren't real

puts names.length.to_s + " Programers with significant contributions"

File.open("names.txt", 'w') do |f|
		names.each do |(name, url)|
			f.write(name)
			f.write(",")
			f.write("http://en.wikipedia.org" + url)
			f.write("\n")
		end
end
