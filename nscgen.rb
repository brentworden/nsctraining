require 'nokogiri'
require 'open-uri'

eventsUrl = "http://training.northernstarbsa.org/Events.aspx"

def processEvent(eventUrl)
  eventPage = Nokogiri::HTML(open(eventUrl))
  name = eventPage.xpath('//span[contains(@id, "_eventName")]/text()')
  startDate = eventPage.xpath('//span[contains(@id, "_eventDateStart")]/text()')
  endDate = eventPage.xpath('//span[contains(@id, "_eventDateEnd")]/text()')
  description = eventPage.xpath('//span[contains(@id, "_eventDesc")]')
  location = eventPage.xpath('//span[contains(@id, "_eventLocation")]/text()')
  address = eventPage.xpath('//span[contains(@id, "_eventAddress")]/text()')
  city = eventPage.xpath('//span[contains(@id, "_eventCity")]/text()')
  state = eventPage.xpath('//span[contains(@id, "_eventState")]/text()')
  zip = eventPage.xpath('//span[contains(@id, "_eventZip")]/text()')
  puts "url: " + eventUrl
  puts "name: " + name.text
  puts "start: " + startDate.text
  puts "end: " + endDate.text
  puts "location: " + location.text
  puts "address: " + address.text
  puts "city: " + city.text
  puts "state: " + state.text
  puts "zip: " + zip.text
  puts "desc: " + description.text
  puts
end

eventsPage = Nokogiri::HTML(open(eventsUrl))   

eventCells = eventsPage.xpath('//table[contains(@id, "DataList_events")]/tr/td')

eventCells.each{ |cell| 
  eventUrl = "http://training.northernstarbsa.org/" + cell.xpath("strong[1]/following-sibling::a/@href").text
  processEvent(eventUrl)
#   break
}
