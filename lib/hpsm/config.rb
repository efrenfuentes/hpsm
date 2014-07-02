require 'yaml'

module Hpsm
  class Config
    def initialize(args)
      raise ArgumentError, "Can't read parameters" if not args.respond_to?(:keys)

      param_hash = args.dup
      if param_hash.has_key?(:file)
        param_yaml = YAML::load_file(param_hash[:file])
        param_hash = {}
        param_yaml.each_key { |k| param_hash[k.to_sym] = param_yaml[k]}
      end

      # Check for params errors
      raise ArgumentError, "Must specify a username" unless param_hash.has_key?(:username)
      raise ArgumentError, "Must specify a password" unless param_hash.has_key?(:password)
      raise ArgumentError, "Must specify a soap end point" unless param_hash.has_key?(:soap_end_point)

      # Get params info
      @config = {}
      @config[:username] = param_hash[:username]
      @config[:password] = param_hash[:password]
      @config[:soap_end_point] = param_hash[:soap_end_point]
    end
  end
end