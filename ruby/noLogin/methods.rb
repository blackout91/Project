post '/signin' do
  if params[:password] == @db.get_first_value("SELECT password FROM users WHERE handle = ?", [params[:user]]) then
    session[:login] = true
    session[:permission] = @db.get_first_value("SELECT permission FROM users WHERE handle = ?", params[:user])
    session[:firstname] = @db.get_first_value("SELECT firstname FROM users WHERE handle = ?", params[:user])
    session[:city] = @db.get_first_value("SELECT city FROM users WHERE handle = ?", params[:user])
    session[:userID] = @db.get_first_value("SELECT userID FROM users WHERE handle = ?", params[:user])
    redirect "#{@db.get_first_value("SELECT permission FROM users WHERE handle = ?", params[:user])}/home"
  end
  redirect "/signIn"
end

post '/signup' do
  @handle_count = @db.get_first_value('SELECT COUNT(*) FROM users WHERE handle = ?',[params[:user].strip])
  if @handle_count == 0 then
    @db.execute(
      'INSERT INTO users VALUES (?,?,?,?,?,?,?,?,?,?,?,?)',
      [getIndexFromTable("users", "userID"), params[:firstname].strip, params[:lastname].strip, params[:address].strip,
      params[:email].strip, params[:homephone].strip, params[:mobphone].strip, params[:user].strip, "user", params[:password].strip, params[:city].strip, 0 ]
    )
    redirect '/home'
  end
end
post '/changeView' do
    session[:city] = params[:city]
    redirect "/home"
end
get '/signOut' do
  session[:login] = false
  session[:permission] = ''
  session[:firstname] = ''
  session[:city] = ''
  redirect '/home'
end