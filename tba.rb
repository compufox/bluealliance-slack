require 'sinatra/base'
require 'active_support/core_ext/time/calculations'
require 'json'
require 'slack-ruby-client'

class BlueAlliance_Hooks < Sinatra::Base
  team = '4055'
  
  post '/tba_events' do
    
    req = JSON.parse(request.body.read)
    data = req['message_data']

    case req['message_type']
    when 'verification'
      puts data['verification_key']

    when 'upcoming_match'
      if data["team_keys"].include? "frc#{team}"
        scheduled = Time.at(data['scheduled_time'].to_i).in_time_zone 'Eastern Time (US & Canada)'
        expected = Time.at(data['predicted_time'].to_i).in_time_zone 'Eastern Time (US & Canada)'

        on_time = scheduled.to_s == expected.to_s
        
        puts "Our next match is coming up! It's scheduled for #{scheduled}" 
      end

    when 'match_score'
      match = data['match']

      
      
    end

  end

end
