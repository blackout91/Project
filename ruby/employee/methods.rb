require_relative '../defsEmployee.rb'
post '/addBasket' do
    #method
    basketIndex = getIndexFromTable("basket", "basketIndex")
    
    @itemID = params[:itemID].strip
    @price =  @db.get_first_value('SELECT price FROM menu WHERE itemID = ?', [@itemID])
    @db.execute('INSERT INTO basket VALUES (?,?,?)',[basketIndex, @itemID, @price])
    redirect '/addOrder'
end

post '/removeBasket' do
    @basketIndex = params[:basketIndex].strip
    @db.execute('DELETE FROM basket WHERE basketIndex = (?)',[@basketIndex])
    redirect '/addOrder'
end

get '/addOrder' do
    if session[:permission] != "employee" && session[:permission] != "admin" then
    redirect "#{session[:permission]}/home"
  end
    @submitted = false
    @results = @db.execute('SELECT * FROM orders')
    @basket = @db.execute('SELECT * FROM basket')
    @orders = @db.execute('SELECT * FROM orders')
    @offers = @db.execute('SELECT * FROM offers')
    @orderdetails = @db.execute('SELECT * FROM orderdetails')
    @menu = @db.execute('SELECT * FROM menu')
    if (params[:ID] != nil) then
        session[:tweetID] = params[:ID]
        session[:tweetText] = @client.status(params[:ID].to_i).text
        session[:userHandle] = "@" + params[:user]
    end
    erb :"employee/addOrder"
end
post '/addOrder' do

    @submitted = true
    @offer = params[:applyOffer]
    @basket = @db.execute('SELECT * FROM basket')
    #converting twitter handle to userID
    @userID = @db.get_first_value('SELECT userID FROM users WHERE handle = ?', params[:twitterHandle])
    @totalprice = 0
    @time = Time.new
    @completion = 'pending'
    @basket.each do |item|
             @totalprice += item[2]
    end
    @fulltime = @time.hour.to_s + ":" + @time.min.to_s
    @month = @time.month
    
    offerCount = @db.get_first_value('SELECT COUNT(*) FROM users WHERE userID = ? AND offers = ?',
                [@userID, @offer])
    #applies offers as appropriate
    if (offerCount > 0)
        @totalprice = @totalprice * @db.get_first_value('SELECT multiplier FROM offers WHERE offerID = ?', [@offer])
        @db.execute('UPDATE users SET offers = "0" WHERE userID = ?', [@userID])
    end
    
    #perform validation
    @userID_ok = !@userID.nil? && @userID != ""
    @totalprice_ok = @totalprice >= 0 && !@totalprice.nil?
    @completion_ok = !@completion.nil?
    
    @orderID = getIndexFromTable("orders", "orderID")
    
    count = @db.get_first_value(
            'SELECT COUNT(*) FROM orders WHERE orderID = ? AND userID = ?
             AND totalprice = ? AND time = ? AND completion = ?',
            [@orderID, @fulltime, @userID, @totalprice, @completion])

    @unique = (count == 0)
    @all_ok = @userID_ok && @totalprice_ok && @completion_ok && @unique
    if @all_ok
        @db.execute(
            'INSERT INTO orders VALUES (?,?,?,?,?,?,?)',
            [@orderID, @fulltime, @userID, @totalprice,  @completion, @month, session[:city]]
         )


         @basket.each do |item|
             @db.execute('INSERT INTO orderdetails VALUES (?,?,?)',[@orderID, item[1],session[:tweetID]])
         end
        @db.execute('DELETE FROM basket')
        end

    redirect "#{session[:permission]}/order"

end
post '/removeOrder' do
    @deleteIndex = params[:ID]
    @db.execute('DELETE FROM orders WHERE orderID = (?)',[@deleteIndex])
    @db.execute('DELETE FROM orderdetails WHERE orderID = (?)',[@deleteIndex])
    redirect "#{session[:permission]}/order"
end
post '/updateStatus' do
    @index = params[:orderID]
    @status = params[:status]
    @db.execute(
            'UPDATE orders SET completion = ? WHERE orderID = ?',
            [@status, @index]
        )
    redirect "#{session[:permission]}/order"

end
post '/reply' do
    @client.update("@" + params[:name] + " " + params[:message], :in_reply_to_status_id => params[:id])
    redirect "#{session[:permission]}/order"
end
post '/inputOrder' do
    @results = @db.execute('SELECT * FROM orders')
    @submitted = trueb
    @time = Time.now
    @orderString = params[:orderString].strip
    @userID = params[:userID].strip
    @completion = 'none'

    @orderString_ok = !@orderString.nil? && @orderString != ""
    @userID_ok = !@userID.nil? && @userID != ""

    @both_ok = @orderString_ok && @userID_ok

    puts(@both_ok)
    if @both_ok
        @orderID = @db.get_first_value('SELECT COUNT(*) FROM orders')
        @db.execute(
            'INSERT INTO orders VALUES (?,?,?,?,?)',
            [@orderID, @time ,@userID, @orderString, @completion]
            )

    end

    redirect '/order'
end

post '/filterByCity' do
    #filterByCity
    getTweets
    usersFromCity = @db.execute("SELECT * FROM users WHERE city = '#{params[:city]}'")
    @filteredTweets = Array.new

    #finding users which have registered in a chosen city
    @tweets.each do |tweet|
        personsHandle = '@' + tweet.user.screen_name #adding @
        usersFromCity.each do |user|
            if personsHandle == user[7]
                @filteredTweets.push(tweet)
            end
        end
    end
    erb :"function/printTweets"

end
post '/addOffer' do
    @user = params[:userID]
    @offer = params[:selectOffer]

    @db.execute('UPDATE users SET offers = ? WHERE userID = ?',
            [@offer, @user])

    redirect "#{session[:permission]}/changeOffers"
end