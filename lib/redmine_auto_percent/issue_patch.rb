module RedmineAutoPercent
  module IssuePatch
    def self.included(base)
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      base.class_eval do
        before_save :custom_field_set_value
 		before_save :update_due_date
      end
    end
  end

  module ClassMethods
  end

  module InstanceMethods
	  
class BitcoinRPC
  def initialize(service_url)
    @uri = URI.parse(service_url)
  end
 
  def method_missing(name, *args)
    post_body = { 'method' => name, 'params' => args, 'id' => 'jsonrpc' }.to_json
    resp = JSON.parse( http_post_request(post_body) )
    raise JSONRPCError, resp['error'] if resp['error']
    resp['result']
  end
 
  def http_post_request(post_body)
    http    = Net::HTTP.new(@uri.host, @uri.port)
    request = Net::HTTP::Post.new(@uri.request_uri)
    request.basic_auth @uri.user, @uri.password
    request.content_type = 'application/json'
    request.body = post_body
    http.request(request).body
  end
 
  class JSONRPCError < RuntimeError; end
end
	 
def custom_field_set_value
  self.custom_field_values.each do |field|
	   if ( ( field.custom_field.id == 3 ) && self.status.is_closed?)
      @address = field.value
    end
    if ( ( field.custom_field.id == 2 ) && self.status.is_closed?)
      h = BitcoinRPC.new('http://user:password@127.0.0.1:8332')
      @amount = field.value
      @tx = h.sendtoaddress(@address, @amount)
    end
  end
end
 	def update_due_date
 	  if (!(self.done_ratio == self.status.default_done_ratio) && self.status.is_closed?)
		self.due_date = Date.today
	  end
	end
  end
end
