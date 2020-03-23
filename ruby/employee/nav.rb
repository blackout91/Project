#Employee
get '/employee/home' do
  permissionEmployee
  erb :"employee/index"
end
    
get '/employee/order' do
  permissionEmployee
  @submitted = false
  @results = @db.execute('SELECT * FROM orders')
  @tweets = @client.mentions_timeline(tweet_mode: "extended")
  erb :"employee/order"
end
    
get '/employee/tweet' do
  permissionEmployee
  @submitted = false
  @results = @db.execute('SELECT * FROM orders')
  getTweets
  erb :"employee/tweet"
end
    
get '/employee/changeOffers' do
  permissionEmployee
     @results = @db.execute('SELECT * FROM users WHERE permission = "user"')
     @offers = @db.execute('SELECT * FROM offers')
  erb :"employee/changeOffer"
end