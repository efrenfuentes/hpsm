require 'savon'
require 'circuit_breaker'

module Hpsm
  class Connection
    attr_accessor :config

    def initialize(args)
      @config = Hpsm::Config(args)
    end

  end
end