require 'sinatra'
require_relative 'app/slack_authorizer'

use SlackAuthorizer

HELP_RESPONSE = "Use `/voybot` to see which AE owns the specific State or Country based on territories. Example: `/voybot New York`".freeze
INVALID_RESPONSE = "Sorry, I don't recognize that city/state/country.".freeze
MALLORIE_REGION = /(New York|NY|Pennsylvania|PA|New Jersey|NJ)/
MALLORIE_RESPONSE = "That area belongs to Mallorie's territory!"

post '/slack/territory' do
  case params['text'].to_s.strip
  when 'help', '' then HELP_RESPONSE
  # when 'NY', 'New York', '' then "Mallorie"
  when MALLORIE_REGION then MALLORIE_RESPONSE
  else INVALID_RESPONSE
  end
end
