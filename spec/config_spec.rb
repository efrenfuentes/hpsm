require 'spec/spec_helper'

describe Config do
  before(:all) do
    @username = 'username'
    @password = 'password'
    @soap_end_point = 'http://host/table.wsdl'
  end

  describe '#new' do
    it 'should accept a config file' do
      conf = Hpsm::Config.new :file => 'spec/config_sample.yml'
      expect(conf).to_not be_nil
    end

    it 'should accept a config hash' do
      conf = Hpsm::Config.new :username => @username, :password => @password, :soap_end_point => @soap_end_point
      expect(conf).to_not be_nil
    end

    it "raise an error if can no't read parameters" do
      expect { conf = Hpsm::Config.new "string" }.to raise_error(ArgumentError)
      expect { conf = Hpsm::Config.new 345 }.to raise_error(ArgumentError)
    end

    it 'should have username' do
      expect { conf = Hpsm::Config.new :password => @password, :soap_end_point => @soap_end_point }.to raise_error(ArgumentError)
    end

    it 'should have password' do
      expect { conf = Hpsm::Config.new :username => @username, :soap_end_point => @soap_end_point }.to raise_error(ArgumentError)
    end

    it 'should a soap end point' do
      expect {  conf = Hpsm::Config.new :username => @username, :password => @password }.to raise_error(ArgumentError)
    end

    it 'soap end point must be a valid url' do
      expect { conf = Hpsm::Config.new :username => @username, :password => @password, :soap_end_point => 'bad soap end point' }.to raise_error(ArgumentError)
    end
  end

  describe 'Properties' do
    before(:each) do
      @conf = Hpsm::Config.new :username => @username, :password => @password, :soap_end_point => @soap_end_point
    end

    it 'have username methods' do
      expect(@conf).to respond_to(:get_username)
      expect(@conf).to respond_to(:set_username)
    end

    it 'have password methods' do
      expect(@conf).to respond_to(:get_password)
      expect(@conf).to respond_to(:set_password)
    end

    it 'have soap end point methods' do
      expect(@conf).to respond_to(:get_soap_end_point)
      expect(@conf).to respond_to(:set_soap_end_point)
    end

    it 'get username' do
      expect(@conf.get_username).to eq(@username)
    end

    it 'get password' do
      expect(@conf.get_password).to eq(@password)
    end

    it 'get soap end point' do
      expect(@conf.get_soap_end_point).to eq(@soap_end_point)
    end

    it 'set username' do
      @conf.set_username('new_username')
      expect(@conf.get_username).to eq('new_username')
    end

    it 'set password' do
      @conf.set_password('new_password')
      expect(@conf.get_password).to eq('new_password')
    end

    describe 'set soap end point' do
      it 'accept valid soap end point' do
        new_soap_end_point = 'http://other-host/table2.wsdl'
        @conf.set_soap_end_point(new_soap_end_point)
        expect(@conf.get_soap_end_point).to eq(new_soap_end_point)
      end
      it 'raise error for invalid soap end point' do
        expect { @conf.set_soap_end_point('invalid_soap_end_point') }.to raise_error(ArgumentError)
      end
    end
  end
end