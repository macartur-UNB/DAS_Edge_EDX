require 'debugger'              # optional, may be helpful
require 'open-uri'              # allows open('http://...') to return body
require 'cgi'                   # for escaping URIs
require 'nokogiri'              # XML parser
require 'active_model'          # for validations

class OracleOfBacon

  class InvalidError < RuntimeError ; end
  class NetworkError < RuntimeError ; end
  class InvalidKeyError < RuntimeError ; end

  attr_accessor :from, :to
  attr_reader :api_key, :response, :uri
  
  include ActiveModel::Validations
  validates_presence_of :from
  validates_presence_of :to
  validates_presence_of :api_key
  validate :from_does_not_equal_to

  def from_does_not_equal_to
    errors.add(:base, "From cannot be the same as To") if @from == @to
  end

  def initialize(api_key='')
    @from = "Kevin Bacon"
    @to = "Kevin Bacon"
    @api_key=api_key
    
  end

  def find_connections
    make_uri_from_arguments
    begin
      xml = URI.parse(uri).read
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
      Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError,
      Net::ProtocolError => e
      # convert all of these into a generic OracleOfBacon::NetworkError,
      #  but keep the original error message
      # your code here
      raise OracleOfBacon::NetworkError
    end
    # your code here: create the OracleOfBacon::Response object
    OracleOfBacon::Response.new(xml)
  end

  def make_uri_from_arguments
    # your code here: set the @uri attribute to properly-escaped URI
    #   constructed from the @from, @to, @api_key arguments
    params = {}
    params["p"] = @api_key
    params["a"] = @from
    params["b"] = @to
    # set encode
    query = URI.encode_www_form(params)
    # set host and path
    host = "www.google.com.br"
    path = "/teste"
     @uri = URI::HTTP.build([nil, host, nil, path, query, nil]).to_s
  end
      
  class Response
    attr_reader :type, :data
    # create a Response object from a string of XML markup.
    def initialize(xml)
      @doc = Nokogiri::XML(xml)
      parse_response
    end

    private

    def parse_response
      if ! @doc.xpath('/error').empty?
        parse_error_response
      elsif !@doc.xpath('/link').empty?
        parse_graph_response
      elsif ! @doc.xpath('/spellcheck').empty?
        parse_spellcheck_response
      else
       @type = :unknown
       @data = 'unknown response type'
      end
    end
    def parse_error_response
      @type = :error
      @data = 'Unauthorized access'
    end
    def parse_graph_response
     @type = :graph
     actor_arr = @doc.xpath('//actor').map(&:text)
     movie_arr = @doc.xpath('//movie').map(&:text)
     @data = actor_arr.zip(movie_arr).flatten.compact
     # zip:
     #    [:a,:b,nil].zip(1,2) == [[:a,1] , [:b,2] , [:c,nil]]
     # flatten
     #     [[:a,1],[:b,2],[:c,nil]].flatten==[:a,1,:b,2,:c,nil]
     # compact 
     #     [:a,1,:c,nil].compact==[:a,1,:c]
    end
    def parse_spellcheck_response
     @type = :spellcheck
     match_arr = @doc.xpath('//match').map(&:text)
     @data = match_arr.flatten.compact
    end
  end
end

