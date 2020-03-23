require 'sinatra'
require 'twitter'
require 'sqlite3'
set :bind, '0.0.0.0' # Only needed if you're running from Codio
include ERB::Util

enable :sessions
set :session_secret, 'team31'

before do
  config = {
      :consumer_key => '6Vf0w722hYY499mXkT0574BcJ',
      :consumer_secret => 'ACzgL8yT5HQ6vfd6jqyYE9Jgq8LcdFQaO2ZFMiHpwQuyG3rz5J',
      :access_token => '963448512376688640-L5p8C9TCNd4iyDrpuB6vFDPEg4vFbkD',
      :access_token_secret => 'vAsgC9CZ5e2kk1CwWurKtIuidpCo4FcINbq2VMdAAtXb1'
  }
  @db = SQLite3::Database.new './public/db'
  @client = Twitter::REST::Client.new(config)
end


require_relative 'ruby/noLogin/nav'
require_relative 'ruby/customer/nav'
require_relative 'ruby/employee/nav'
require_relative 'ruby/employee/admin/nav'

require_relative 'ruby/noLogin/methods'
require_relative 'ruby/customer/methods'
require_relative 'ruby/employee/methods'
require_relative 'ruby/employee/admin/methods'

require_relative 'ruby/defsGeneral'

not_found do
  '404 Page not found'
end
