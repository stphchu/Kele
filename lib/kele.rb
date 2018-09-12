require 'rubygems' if RUBY_VERSION < '1.9'
require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap
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
    @user = JSON.parse(response.body)
  end

#GET_MENTOR_AVAILABILITY
  def get_mentor_availability(mentor_id)
    response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: { "authorization" =>  @auth_token })
    @mentor_schedule = JSON.parse(response.body).to_a
    
    mentor_availability = []
    
    @mentor_schedule.each do |timeslot|
	if timeslot["booked"] == nil
	    mentor_availability.push(timeslot)
        end
    end
     mentor_availability 
  end

end
