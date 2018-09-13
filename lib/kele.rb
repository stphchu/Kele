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
    response = self.class.post("/sessions", body: { email: email, password: password })    

    if response.code != 200
      p "Invalid email or password"
    else
      @auth_token = response["auth_token"]
      @user_email = email
    end
  end

#GET_ME
  def get_me
    response = self.class.get("/users/me", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

#GET_MENTOR_AVAILABILITY
  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    @mentor_schedule = JSON.parse(response.body).to_a
    
    mentor_availability = []
    
    @mentor_schedule.each do |timeslot|
	if timeslot["booked"] == nil
	    mentor_availability.push(timeslot)
        end
    end
     mentor_availability
  end

#GET_MESSAGES
  def get_messages(page = nil)
     if page != nil
        message_url = "/message_threads?page=#{page}"
     else
        message_url = "/message_threads"
     end
     
     response = self.class.get(message_url, headers: { "authorization" => @auth_token })
     JSON.parse(response.body)
  end

#CREATE_MESSAGE
  def create_message(recipient_id, subject, stripped_text)
     sender = @user_email
     response = self.class.post("/messages", headers: { "authorization" => @auth_token }, 
		body: { sender: sender, recipient_id: recipient_id, subject: subject, stripped-text => stripped_text })
     if response.success?
	p "Message is sent"
     else
	p "There was an error sending the message. Please try again."
     end  
  end

end
