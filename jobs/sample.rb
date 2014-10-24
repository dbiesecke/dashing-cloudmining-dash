#require 'uri'
#require 'net/http'
#
#
#SCHEDULER.every '20s' do
#  result = Net::HTTP.get(URI.parse('https://btc.sx:80/api/ticker.php'))
#  parsed = JSON.parse(result) # returns a hash
#  
#  last_buyprice = current_buyprice
#  last_sellprice     = current_sellprice
#  current_buyprice  = parsed[buyprice]
#  current_sellprice      = parsed[sellprice]
#
#
#  send_event('karma', { current: current_buyprice , last: last_buyprice  })
#
#end