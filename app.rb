require 'sinatra'
require_relative 'app/slack_authorizer'

use SlackAuthorizer

HELP_RESPONSE = "Use `/voybot` to see which AE owns the specific State or Country based on territories. Example: `/voybot New York`".freeze
INVALID_RESPONSE = "Sorry, I don't recognize that city/state/country.".freeze

post '/slack/territory' do
  case params['text'].to_s.strip
  when 'help',  then HELP_RESPONSE
  when 'NY', then "Mallorie"
  else INVALID_RESPONSE
  end
end
