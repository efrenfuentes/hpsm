require 'spec/spec_helper'

describe Config do

  describe '#new' do
    it 'should accept a config file' do
      conf = Hpsm::Config.new :file => 'spec/config_sample.yml'
      expect(conf).to_not be_nil
    end

    it 'should accept a config hash' do
      conf = Hpsm::Config.new :username => 'user', :password => 'password', :soap_end_point => 'soap'
      expect(conf).to_not be_nil
    end

    it "raise an error if can no't read parameters" do
      expect { conf = Hpsm::Config.new "string" }.to raise_error(ArgumentError)
      expect { conf = Hpsm::Config.new 345 }.to raise_error(ArgumentError)
    end

    it 'should have username' do
      expect { conf = Hpsm::Config.new :password => 'password', :soap_end_point => 'soap' }.to raise_error(ArgumentError)
    end

    it 'should have password' do
      expect { conf = Hpsm::Config.new :username => 'user', :soap_end_point => 'soap' }.to raise_error(ArgumentError)
    end

    it 'should a soap end point' do
      expect {  conf = Hpsm::Config.new :username => 'user', :password => 'password' }.to raise_error(ArgumentError)
    end
  end
end