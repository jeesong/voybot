require 'sinatra'
require_relative 'app/slack_authorizer'

use SlackAuthorizer

HELP_RESPONSE = "Use `/salesbot` to see which AE owns the specific State or Country based on territories or a list of states that the AE owns. \nExample: `/salesbot New York` or `/salesbot NY` or `/salesbot Hayley`".freeze
HAYLEY_REGION = /([Ss]ocal|[Ll]os [Aa]ngeles|OR|or|TX|tx|[Oo]regon|[Tt]exas)/
HAYLEY_RESPONSE = "%s belongs to Hayley's territory.".freeze
SEAN_REGION = /(OK|ok|AR|ar|LA|la|MS|ms|GA|ga|FL|fl|SC|sc|NC|nc|TN|tn|VA|va|AL|al|[Oo]klahoma|[Aa]rkansas|[Ll]ouisiana|[Mm]ississippi|[Gg]eorgia|[Ff]lordia|[Ss]outh [Cc]arolina|[Nn]orth [Cc]arolina|[Tt]ennessee|[Vv]irginia|[Aa]labama)/
SEAN_RESPONSE = "%s belongs to Sean's territory.".freeze
CA_Response = "California is split between Hayley, Jim, and Heather Votel. Hayley is responsible for SoCal, Jim is responsible for SF & East Bay, Heather V is responsible for Peninsula & South Bay."
WA_Response = "Washington is round robined amongst the Enterprise AE team."
JULIAN_REGION = /(NY|ny|NJ|nj|DE|de|RI|ri|VT|vt|NH|nh|ME|me|QC|qc|MB|mb|NB|nb|NS|ns|[Nn]ew [Yy]ork|[Nn]ew [Jj]ersey|[Dd]elaware|[Rr]hode [Ii]sland|[Vv]ermont|[Nn]ew [Hh]ampshire|[Mm]aine|[Qq]uebec|[Mm]anitoba|[Nn]ew [Bb]runswick|[Nn]ova [Ss]cotia)/
JULIAN_RESPONSE = "%s belongs to Julian's territory.".freeze
JIM_REGION = /(AK|ak|BC|bc|AB|ab|ON|on|NM|nm|HI|hi|[Aa]laska|[Bb]ritish [Cc]olumbia|[Aa]lberta|[Oo]ntario|[Nn]ew [Mm]exico|[Hh]awaii)/
JIM_RESPONSE = "%s belongs to Jim's territory.".freeze
HEATHER_BELL_REGION = /(ND|nd|SD|sd|NE|ne|KS|ks|MN|mn|IA|ia|MO|mo|WI|wi|IL|il|IN|in|MI|mi|[Nn]orth [Dd]akota|[Ss]outh [Dd]akota|[Nn]ebraska|[Kk]ansas|[Mm]inesota|[Ii]owa|[Mm]isouri|[Ww]isconsin|[Ii]llinois|[Ii]ndiana|[Mm]ichigan)/
HEATHER_BELL_RESPONSE = "%s belongs to Heather Bell's territory.".freeze
HEATHER_VOTEL_REGION = /(SK|sk|MT|mt|ID|id|WY|wy|NV|nv|UT|ut|CO|co|AZ|az|[Ss]askatchewan|[Mm]ontana|[Ii]daho|[Ww]yoming|[Nn]evada|[Uu]tah|[Cc]olorado|[Aa]rizona)/
HEATHER_VOTEL_RESPONSE = "%s belongs to Heather Votel's territory.".freeze
EMILY_REGION = /(KY|ky|WV|wv|OH|oh|PA|pa|MD|md|DC|dc|CT|ct|MA|ma|[Kk]entucky|[Ww]est [Vv]irginia|[Oo]hio|[Pp]ensylvania|[Mm]aryland|[Ww]ashington [Dd][Cc]|[Cc]onnecticut|[Mm]assachusetts)/
EMILY_RESPONSE = "%s belongs to Emily's territory.".freeze
EVAN_REGION = /([Uu]nited [Kk]ingdom|[Ii]reland|[Ss]weden|[Dd]enmark|[Ff]inland|[Nn]orway)/
EVAN_RESPONSE = "%s belongs to Evan's territory.".freeze

post '/slack/territory' do
  case params['text'].to_s.strip
  when 'help', '' then HELP_RESPONSE
  when 'CA', 'ca', 'california', 'California', '' then CA_Response
  when 'WA', 'wa', 'washington', 'Washington', '' then WA_Response
  when HAYLEY_REGION then HAYLEY_RESPONSE % $1
  when 'Hayley', '' then "Hayley's Territory: Southern California, Oregon, Texas"
  when SEAN_REGION then SEAN_RESPONSE % $1
  when 'Sean', '' then "Sean's Territory: Alabama, Arkansas, Florida, Georgia, Louisiana, Mississippi, North Carolina, Oklahoma, South Carolina, Tennessee, Virginia"
  when JULIAN_REGION then JULIAN_REGION % $1
  when 'Julian', '' then "Julian's Territory: Delaware, Maine, Manitoba, New Brunswick, New Hampshire, New Jersey, New York, Nova Scotia, Quebec, Rhode Island, Vermont"
  when JIM_REGION then JIM_RESPONSE % $1
  when 'Jim', '' then "Jim's Territory: San Francisco, East Bay (CA), Alaska, British Columbia, Hawaii, New Mexico, Ontario"
  when HEATHER_BELL_REGION then HEATHER_BELL_RESPONSE % $1
  when 'Heather Bell', '' then "Heather Bell's Territory: Illinois, Indiana, Iowa, Kansas, Michigan, Minnesota, Missouri, Nebraska, North Dakota, South Dakota, Wisconsin"
  when HEATHER_VOTEL_REGION then HEATHER_VOTEL_RESPONSE % $1
  when 'Heather Votel', '' then "Heather Votel's Territory: Peninsula (CA), South Bay (CA), Arizona, Colorado, Idaho, Montana, Nevada, Saskatchewan, Utah, Wyoming"
  when EMILY_REGION then EMILY_RESPONSE % $1
  when 'Emily', '' then "Emily's Territory: Connecticut, Kentucky, Maryland, Massachusetts, Ohio, Pennsylvania, Washington DC, West Virginia"
  when EVAN_REGION then EVAN_RESPONSE % $1
  when 'Evan', '' then "Evan's Territory: United Kingdom, Ireland, Norway, Finland, Denmark, Sweden"
  else "Sorry I don't recognize #{params['text']} :sadparrot:"
  end
end
