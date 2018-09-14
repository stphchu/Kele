require 'httparty'
require 'json'

module Roadmap
  include HTTParty
  base_uri "https://www.bloc.io/api/v1"

#GET_ROADMAP  
  def get_roadmap(chain_id)    
     response = self.class.get("/roadmaps/#{chain_id}", headers: { "authorization" =>  @auth_token })    
     JSON.parse(response.body)  
  end

#GET_CHECKPOINT  
  def get_checkpoint(checkpoint_id)
     response = self.class.get("/checkpoints/#{checkpoint_id}", headers: { "authorization" =>  @auth_token })
     JSON.parse(response.body)
  end

#GET_REMAINING_CHECKPOINTS
  def get_remaining_checkpoints(chain_id)
     response = self.class.get("/enrollment_chains/#{chain_id}/checkpoints_remaining_in_section", headers: { "authorization" => @auth_token })
     JSON.parse(response.body)
  end

end
