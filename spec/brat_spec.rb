require 'spec_helper'

describe Brat do
  after { Brat.reset }

  describe ".client" do
    it "should be a Brat::Client" do
      expect(Brat.client).to be_a Brat::Client
    end
  end

  describe ".actions" do
    it "should return an array of client methods" do
      actions = Brat.actions
      expect(actions).to be_an Array
      expect(actions.first).to be_a Symbol
      expect(actions.sort.first).to match(/add_/)
    end
  end

  describe ".endpoint=" do
    it "should set endpoint" do
      Brat.endpoint = 'https://api.example.com'
      expect(Brat.endpoint).to eq('https://api.example.com')
    end
  end

  describe ".private_token=" do
    it "should set private_token" do
      Brat.private_token = 'secret'
      expect(Brat.private_token).to eq('secret')
    end
  end

  describe ".sudo=" do
    it "should set sudo" do
      Brat.sudo = 'user'
      expect(Brat.sudo).to eq('user')
    end
  end

  describe ".user_agent" do
    it "should return default user_agent" do
      expect(Brat.user_agent).to eq(Brat::Configuration::DEFAULT_USER_AGENT)
    end
  end

  describe ".user_agent=" do
    it "should set user_agent" do
      Brat.user_agent = 'Custom User Agent'
      expect(Brat.user_agent).to eq('Custom User Agent')
    end
  end

  describe ".configure" do
    Brat::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set #{key}" do
        Brat.configure do |config|
          config.send("#{key}=", key)
          expect(Brat.send(key)).to eq(key)
        end
      end
    end
  end
end
