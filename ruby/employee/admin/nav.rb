#Admin
get '/admin/home' do
  permissionAdmin
  erb :"employee/index"
end
get '/admin/order' do
  permissionAdmin
  @submitted = false
  @results = @db.execute('SELECT * FROM orders')
  @tweets = @client.mentions_timeline(tweet_mode: "extended")
  erb :"employee/order"
end
get '/admin/history' do
  permissionAdmin
  @results = @db.execute('SELECT * FROM orders WHERE completion = "completed"')
  erb :"admin/history"
end
get '/admin/tweet' do
  permissionAdmin
  @submitted = false
  @results = @db.execute('SELECT * FROM orders')
  getTweets
  erb :"employee/tweet"
end
get '/admin/changeOffers' do
  permissionAdmin
  @results = @db.execute('SELECT * FROM users WHERE permission = "user"')
  @offers = @db.execute('SELECT * FROM offers')
  erb :"employee/changeOffer"
end
get '/admin/menu' do
  permissionAdmin
  @results = @db.execute('SELECT * FROM menu')
  erb :"admin/menu"
end
get '/admin/changeMenu' do
  permissionAdmin
  @index = params[:itemID]
  @results = @db.execute('SELECT * FROM menu WHERE itemID = ?',[@index])
  erb :"admin/changeMenu"
end
get '/admin/changeCustomer' do
  permissionAdmin
  @results = @db.execute('SELECT * FROM users')
  erb :"admin/changeCustomer"
end
get '/admin/changeUser' do
  permissionAdmin
  @index = params[:userID]
  @results = @db.execute('SELECT * FROM users WHERE userID = ?',[@index])
  erb :"admin/changeUser"
end
get '/admin/analytics' do
  permissionAdmin
  @tweets = @client.mentions_timeline()
  @month = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
  @values1 = Array.new
  (1..12).each do |i|
      @values1.push(@db.get_first_value('SELECT COUNT(*) FROM orders WHERE month = ?',[i]))
  end
  @values2 = Array.new
     @values = Array.new
  @tweets.each do |tweet|
      @values.push(tweet.created_at.month)
  end
  (1..12).each do |i|
      @values2.push(@values.count(i))
  end
  erb :"admin/analytics"
end