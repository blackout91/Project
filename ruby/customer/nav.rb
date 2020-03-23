#user
get '/user/home' do
  permissionCustomer
  erb :"user/index"
end
get '/user/menu' do
  permissionCustomer
  @results = @db.execute('SELECT * FROM menu WHERE city = ?',[session[:city]])
  @arr = Array.new
  @results.each do |item|
      if (@arr.index item[1]) == nil
          @arr.push(item[1])
      end
  end
  erb :"user/menu"
end
get '/user/details' do
  permissionCustomer
  @index = session[:userID]
  @results = @db.execute('SELECT * FROM users WHERE userID = ?',[@index])
  erb :"admin/changeUser"
end
get '/user/offers' do
  permissionCustomer
  erb :"user/offers"
end