require 'sinatra'
require_relative 'app/slack_authorizer'

use SlackAuthorizer

HELP_RESPONSE = "Use `/voybot` to see which AE owns the specific State or Country based on territories. Example: `/voybot New York`".freeze
INVALID_RESPONSE = "Sorry, I don't recognize %s.".freeze
MALLORIE_REGION = /(New York|NY|Pennsylvania|PA|New Jersey|NJ)/
MALLORIE_RESPONSE = "%s belongs to Mallorie's territory!".freeze
# TEILA_REGION = /()/
# TEILA_RESPONSE =
# ROSS_REGION = //
# ROSS_RESPONSE =
# HAYLEY_REGION = //
# HAYLEY_RESPONSE =
# NATE_REGION = //
# NATE_RESPONSE =
# SEAN_REGION = //
# SEAN_RESPONSE =

post '/slack/territory' do
  case params['text'].to_s.strip
  when 'help', '' then HELP_RESPONSE
  when MALLORIE_REGION then MALLORIE_RESPONSE % $1
  # when TEILA_REGION then TEILA_RESPONSE
  # when NATE_REGION then NATE_RESPONSE
  # when HAYLEY_REGION then HAYLEY_RESPONSE
  # when ROSS_REGION then ROSS_RESPONSE
  # when SEAN_REGION then SEAN_RESPONSE
  else INVALID_RESPONSE % $1
  end
end
