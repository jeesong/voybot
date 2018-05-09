require 'sinatra'
require_relative 'app/slack_authorizer'

use SlackAuthorizer

HELP_RESPONSE = "Use `/salesbot` to see which AE owns the specific State or Country based on territories or a list of states that the AE owns. \nExample: `/salesbot New York` or `/salesbot NY` or `/salesbot Mallorie`".freeze
MALLORIE_US_REGION = /([Nn]ew [Yy]ork|NY|[Pp]ennsylvania|PA|[Nn]ew [Jj]ersey|NJ|[Oo]hio|[Ww]est [Vv]irginia|OH|WV)/
MALLORIE_ROW_REGION = /([Ss]ingapore|[Nn]ew [Zz]eland|[Jj]apan|[Ii]ndia|[Cc]hina|[Aa]ustralia)/
MALLORIE_RESPONSE = "%s belongs to Mallorie's territory!".freeze
TEILA_US_REGION = /(CT|MA|RI|NH|VT|ME|DE|VA|MD|DC|[Dd]elaware|[Cc]onnecticut|[Mm]aine|[Rr]hode [Ii]sland|[Nn]ew [Hh]ampshire|[Vv]ermont|[Mm]assachusetts|[Vv]irginia|[Mm]aryland|[Ww]ashington [Dd][Cc])/
TEILA_ROW_REGION = /([Ee]ngland|[Ii]reland|[Uu]nited [Kk]ingdom|[Ff]rance|[Ss]pain|[Ii]taly|[Gg]reece|[Bb]elgium|[Pp]ortugal|[Oo]ntario|[Qq]uebec)/
TEILA_RESPONSE = "%s belongs to Teila's territory!".freeze
ROSS_US_REGION = /(OR|WA|AK|HI|[Hh]awaii|[Aa]laska|[Ww]ashington|[Oo]regon)/
ROSS_ROW_REGION = //
ROSS_RESPONSE = "%s belongs to Ross' territory!".freeze
HAYLEY_US_REGION = /([Ss]ocal|[Ss]an [Ff]rancisco|[lL]os [Aa]ngeles|AZ|[Aa]rizona)/
HAYLEY_RESPONSE = "%s belongs to Hayley's territory!".freeze
NATE_US_REGION = /(NV|ID|MT|WY|UT|CO|NM|KS|NE|SD|ND|MN|IA|MO|WI|IL|IN|MI|KY|[Cc]olorado|[Nn]evada|[Uu]tah|[nN]ew [Mm]exico|[Ww]yoming|[Ii]daho|[Mm]ontana|[Nn]orth [Dd]akota|[Ss]outh [Dd]akota|[Mm]innesota|[Ii]owa|[Mm]issouri|[Ii]llinoise|[Ww]isconsin|[Ii]ndiana|[Kk]entucky|[Mm]ichigan)/
NATE_ROW_REGION = //
NATE_RESPONSE = "%s belongs to Nate's territory!".freeze
SEAN_US_REGION = /(TX|OK|AR|LA|MS|GA|FL|SC|NC|TN|[Tt]exas|[Oo]klahoma|[Aa]rkansas|[Ll]ouisiana|[Mm]ississippi|[Gg]eorgia|[Ff]lordia|[Ss]outh [Cc]arolina|[Nn]orth [Cc]arolina|[Tt]ennessee)/
SEAN_ROW_REGION = //
SEAN_RESPONSE = "%s belongs to Sean's territory!".freeze
CA_Response = "California is split between Hayley & Ross. Ross is responsible for NorCal (except SF) and Hayley is responsible for SoCal & SF"

post '/slack/territory' do
  case params['text'].to_s.strip
  when 'help', '' then HELP_RESPONSE
  when 'CA', 'ca', 'california', 'California', '' then CA_Response
  when MALLORIE_US_REGION, MALLORIE_ROW_REGION then MALLORIE_RESPONSE % $1
  when 'Mallorie', '' then "Mallorie's Territory: New York, Pennsylvania, New Jersey, Ohio, West Virginia"
  when TEILA_US_REGION, TEILA_ROW_REGION then TEILA_RESPONSE % $1
  when 'Teila', '' then "Teila's Territory: Connecticut, Maine, Rhode Island, New Hampshire, Vermont, Massachusetts, Delaware, Virginia, Maryland, Washington DC"
  when NATE_US_REGION then NATE_RESPONSE % $1
  when 'Nate', '' then "Nate's Territory: Colorado, Nevada, Utah, New Mexico, Wyoming, Idaho, Montana, North Dakota, South Dakota, Minnesota, Iowa, Missouri, Illinoise, Wisconsin, Indiana, Kentucky, Michigan"
  when HAYLEY_US_REGION then HAYLEY_RESPONSE % $1
  when 'Hayley', '' then "Hayley's Territory: San Francisco, Southern California, Arizona"
  when ROSS_US_REGION then ROSS_RESPONSE % $1
  when 'Ross', '' then "Ross' Territory: Northern California, Hawaii, Alaska, Washington State, Oregon"
  when SEAN_US_REGION then SEAN_RESPONSE % $1
  when 'Sean', '' then "Sean's Territory: Texas, Oklahoma, Arkansas, Louisiana, Mississippi, Georgia, Florida, South Carolina, North Carolina, Tennessee"
  else "Sorry I don't recognize #{params['text']} :sadparrot:"
  end
end
