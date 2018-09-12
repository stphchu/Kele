require 'httparty'
require 'json'

module Roadmap
  include HTTParty
  base_uri "https://www.bloc.io/api/v1/"

#GET_ROADMAP  
  def get_roadmap(chain_id)    
     response = self.class.get("https://www.bloc.io/api/v1/roadmaps/#{chain_id}", headers: { "authorization" =>  @auth_token })    
     JSON.parse(response.body)  
  end

#GET_CHECKPOINT  
  def get_checkpoint(checkpoint_id)
     response = self.class.get("https://www.bloc.io/api/v1/checkpoints/#{checkpoint_id}", headers: { "authorization" =>  @auth_token })
  end

end
