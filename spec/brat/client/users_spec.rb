require 'spec_helper'

describe Brat::Client do
  describe ".users" do
    before do
      stub_get("/users", "users")
      @users = Brat.users
    end

    it "should get the correct resource" do
      expect(a_get("/users")).to have_been_made
    end

    it "should return an array of users" do
      expect(@users).to be_an Array
      expect(@users.first.email).to eq("john@example.com")
    end
  end

  describe ".user" do
    context "with user ID passed" do
      before do
        stub_get("/users/1", "user")
        @user = Brat.user(1)
      end

      it "should get the correct resource" do
        expect(a_get("/users/1")).to have_been_made
      end

      it "should return information about a user" do
        expect(@user.email).to eq("john@example.com")
      end
    end

    context "without user ID passed" do
      before do
        stub_get("/user", "user")
        @user = Brat.user
      end

      it "should get the correct resource" do
        expect(a_get("/user")).to have_been_made
      end

      it "should return information about an authorized user" do
        expect(@user.email).to eq("john@example.com")
      end
    end
  end

  describe ".create_user" do
    context "when successful request" do
      before do
        stub_post("/users", "user")
        @user = Brat.create_user("email", "pass")
      end

      it "should get the correct resource" do
        body = {:email => "email", :password => "pass", :name => "email"}
        expect(a_post("/users").with(:body => body)).to have_been_made
      end

      it "should return information about a created user" do
        expect(@user.email).to eq("john@example.com")
      end
    end

    context "when bad request" do
      it "should throw an exception" do
        stub_post("/users", "error_already_exists", 409)
        expect {
          Brat.create_user("email", "pass")
        }.to raise_error(Brat::Error::Conflict, "Server responded with code 409, message: 409 Already exists. Request URI: #{Brat.endpoint}/users")
      end
    end
  end

  describe ".edit_user" do
    before do
      @options = { :name => "Roberto" }
      stub_put("/users/1", "user").with(:body => @options)
      @user = Brat.edit_user(1, @options)
    end

    it "should get the correct resource" do
      expect(a_put("/users/1").with(:body => @options)).to have_been_made
    end
  end

  describe ".session" do
    after do
      Brat.endpoint = 'https://api.example.com'
      Brat.private_token = 'secret'
    end

    before do
      stub_request(:post, "#{Brat.endpoint}/session").
        to_return(:body => load_fixture('session'), :status => 200)
      @session = Brat.session("email", "pass")
    end

    context "when endpoint is not set" do
      it "should raise Error::MissingCredentials" do
        Brat.endpoint = nil
        expect {
          Brat.session("email", "pass")
        }.to raise_error(Brat::Error::MissingCredentials, 'Please set an endpoint to API')
      end
    end

    context "when private_token is not set" do
      it "should not raise Error::MissingCredentials" do
        Brat.private_token = nil
        expect { Brat.session("email", "pass") }.to_not raise_error
      end
    end

    context "when endpoint is set" do
      it "should get the correct resource" do
        expect(a_request(:post, "#{Brat.endpoint}/session")).to have_been_made
      end

      it "should return information about a created session" do
        expect(@session.email).to eq("john@example.com")
        expect(@session.private_token).to eq("qEsq1pt6HJPaNciie3MG")
      end
    end
  end

  describe ".ssh_keys" do
    before do
      stub_get("/user/keys", "keys")
      @keys = Brat.ssh_keys
    end

    it "should get the correct resource" do
      expect(a_get("/user/keys")).to have_been_made
    end

    it "should return an array of SSH keys" do
      expect(@keys).to be_an Array
      expect(@keys.first.title).to eq("narkoz@helium")
    end
  end

  describe ".ssh_key" do
    before do
      stub_get("/user/keys/1", "key")
      @key = Brat.ssh_key(1)
    end

    it "should get the correct resource" do
      expect(a_get("/user/keys/1")).to have_been_made
    end

    it "should return information about an SSH key" do
      expect(@key.title).to eq("narkoz@helium")
    end
  end

  describe ".create_ssh_key" do
    before do
      stub_post("/user/keys", "key")
      @key = Brat.create_ssh_key("title", "body")
    end

    it "should get the correct resource" do
      body = {:title => "title", :key => "body"}
      expect(a_post("/user/keys").with(:body => body)).to have_been_made
    end

    it "should return information about a created SSH key" do
      expect(@key.title).to eq("narkoz@helium")
    end
  end

  describe ".delete_ssh_key" do
    before do
      stub_delete("/user/keys/1", "key")
      @key = Brat.delete_ssh_key(1)
    end

    it "should get the correct resource" do
      expect(a_delete("/user/keys/1")).to have_been_made
    end

    it "should return information about a deleted SSH key" do
      expect(@key.title).to eq("narkoz@helium")
    end
  end
end
