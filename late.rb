# Lets everyone know if you are running late.
# Usage: rails runner script/running_late.rb

dayofweek = Time.new.wday
# Skip on weekends
exit if Time.now.instance_eval { saturday? || sunday? }

SLACK_TOKEN = ''
SLACK_CHANNEL = ''
USER_ID = ''

excuses = [
  'Forgot my keys',
  'Running an errand',
  'Waiting for red line to clear up',
  'Playing Halo',
  'Zombie apocolypse is taking place!'
  'Overslept',
  'Massive hangover',
  'Dog ate my charlie card',
  'Tripped on an esclator and needs to get my teeth fixed'
]

message = "I am running late. #{excuses[rand(excuses.length)]}"

response = Faraday.get "https://slack.com/api/users.getPresence?token=#{SLACK_TOKEN}&user=#{USER_ID}"
payload = Oj.load(response.body)

if payload['presence']=='away'
  Faraday.post "https://slack.com/api/chat.postMessage?token=#{SLACK_TOKEN}&channel=#{SLACK_CHANNEL}&text=#{message}"
end
