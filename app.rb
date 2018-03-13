require 'sinatra'
require_relative 'app/slack_authorizer'

use SlackAuthorizer

HELP_RESPONSE = "Use `/voybot` to see which AE owns the specific State or Country based on territories. Example: `/voybot New York`".freeze
INVALID_RESPONSE = "Sorry, I don't recognize %s.".freeze
MALLORIE_REGION = /(New York|NY|Pennsylvania|PA|New Jersey|NJ)/
MALLORIE_RESPONSE = "%s belongs to Mallorie's territory!".freeze
TEILA_REGION = /(CT|MA|RI|NH|VT|ME|DE|Delaware|Connecticut|Maine|Rhode Island|New Hampshire|Vermont|Massachusetts)/
TEILA_RESPONSE = "%s belongs to Teila's territory!".freeze
ROSS_REGION = /(OR|WA|AK|HI|Hawaii|Alaska|Washington|Oregon)/
ROSS_RESPONSE = "%s belongs to Ross' territory!".freeze
HAYLEY_REGION = /(Socal|San Francisco|Los Angeles)/
HAYLEY_RESPONSE = "%s belongs to Hayley's territory!".freeze
NATE_REGION = /(NV|ID|MT|WY|UT|CO|AZ|NM|KS|NE|SD|ND|MN|IA|MO|WI|IL|IN|MI|KY|OH|WV|Nevada|Utah|Arizona|New Mexico|Wyoming|Idaho|Montana|North Dakota|South Dakota|Minnesota|Iowa|Missouri|Illinoise|Wisconsin|Indiana|Kentucky|Ohio|West Virginia|Michigan)/
NATE_RESPONSE = "%s belongs to Nate's territory!".freeze
SEAN_REGION = /(TX|OK|AR|LA|MS|GA|FL|SC|NC|TN|VA|MD|DC|Texas|Oklahoma|Arkansas|Louisiana|Mississippi|Georgia|Flordia|South Carolina|North Carolina|Tennessee|Virginia|Maryland|Washington DC)/
SEAN_RESPONSE = "%s belongs to Sean's territory!".freeze
CA_Response = "California is split between Hayley & Ross. Ross is responsible for NorCal (except SF) and Hayley is responsible for SoCal & SF"

post '/slack/territory' do
  case params['text'].to_s.strip
  when 'help', '' then HELP_RESPONSE
  when 'CA', '' then CA_Response
  when MALLORIE_REGION then MALLORIE_RESPONSE % $1
  when TEILA_REGION then TEILA_RESPONSE % $1
  when NATE_REGION then NATE_RESPONSE % $1
  when HAYLEY_REGION then HAYLEY_RESPONSE % $1
  when ROSS_REGION then ROSS_RESPONSE % $1
  when SEAN_REGION then SEAN_RESPONSE % $1
  else INVALID_RESPONSE % $1
  end
end
