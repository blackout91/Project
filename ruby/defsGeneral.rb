def getTweets
  @tweets = Array.new
  rawTweets = @client.mentions_timeline(tweet_mode: "extended")
  rawTweets.each do |tweet|
    if tweet.attrs[:full_text].include? "#order" then
      @tweets.push(tweet)
    end
  end
end

def permissionAdmin
    if session[:permission] != "admin" then
        redirect "#{session[:permission]}/home"
    end
end

def permissionEmployee
  if session[:permission] != "employee" then
    redirect "#{session[:permission]}/home"
  end
end

def permissionCustomer
  if session[:permission] != "user" then
    redirect "#{session[:permission]}/home"
  end
end

def permissionNav
    if session[:permission] == "admin"
        erb :"template/adminNav"
    elsif session[:permission] =="employee"
        erb :"template/employeeNav"
    else
        erb :"template/userNav"
    end
end

def tweetChecked(tweetID)

  @orderTweetIDs = @db.execute('SELECT tweetID FROM orderdetails')
  if @orderTweetIDs.length == 0 then
    return false
  end
  @orderTweetIDs.each do |id|
    if id[0] == tweetID then
      return true
    end
  end
  return false
end

def printDetails(i)
  @detailString = "Details: "
  @orderdetails = @db.execute('SELECT itemID FROM orderdetails WHERE orderID = ?', [i])
    @orderdetails.each do |detail|
      @detailString = @detailString + @db.get_first_value('SELECT item FROM menu WHERE itemID = ?', [detail]) + "-"  + @db.get_first_value('SELECT size FROM menu WHERE itemID = ?', [detail])+ ", "
  end
end

def getTweetByOrderID(i)
  @tweetString = @client.status(@db.get_first_value('SELECT tweetID FROM orderdetails WHERE orderID = ?', [i])).text
end