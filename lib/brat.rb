require 'brat/version'
require 'brat/objectified_hash'
require 'brat/configuration'
require 'brat/error'
require 'brat/request'
require 'brat/api'
require 'brat/client'

module Brat
  extend Configuration

  # Alias for Brat::Client.new
  #
  # @return [Brat::Client]
  def self.client(options={})
    Brat::Client.new(options)
  end

  # Delegate to Brat::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Brat::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end

  # Returns an unsorted array of available client methods.
  #
  # @return [Array<Symbol>]
  def self.actions
    hidden = /endpoint|private_token|user_agent|sudo|get|post|put|\Adelete\z|validate|set_request_defaults/
    (Brat::Client.instance_methods - Object.methods).reject {|e| e[hidden]}
  end
end
