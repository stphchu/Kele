require 'rubygems' if RUBY_VERSION < '1.9'
require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri "https://www.bloc.io/api/v1"

#INITIALIZE
  def initialize(email, password)
    response = self.class.post("https://www.bloc.io/api/v1/sessions/", body: { email: email, password: password })
    
    if response.code != 200
      p "Invalid email or password"
    else
      @auth_token = response["auth_token"]
    end
  end

#GET_ME
  def get_me
    response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" =>  @auth_token })
    JSON.parse(response.body)
  end


end
