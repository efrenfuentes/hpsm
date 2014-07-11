require 'savon'
require 'circuit_breaker'

module Hpsm
  class Connection
    attr_accessor :config, :client

    def initialize(args)
      @config = Hpsm::Config(args)
      @client = Savon.client do
        wsdl @config.soap_end_point
        basic_auth @config.username, @config.password
      end
    end

    def call(operation, message)
      response = @client.call(operation, message)
      response.body
    end

    def create_incident(incident_id, service, category, urgency, assignment_group, description,
                        area, sub_area, title, impact)
      keys = {:IncidentID => incident_id }
      instance ={:Service => service,
                 :IncidentID => incident_id,
                 :Category => category,
                 :Urgency => urgency,
                 :assignment_group => assignment_group,
                 :description => description,
                 :area => area,
                 :sub_area => sub_area,
                 :title => title,
                 :impact => impact}
      message = {:keys => keys, :instance => instance}
      response_body = call(:create_incident, message)
    end
  end
end