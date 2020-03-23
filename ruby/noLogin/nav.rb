#Nav
#No login
get '/home' do
  if session[:login] then
    redirect "#{session[:permission]}/home"
  end
   if session[:city].nil? || session[:city] ==""
       @results = @db.execute('SELECT * FROM menu WHERE city = "sheffield"')
   else 
       @results = @db.execute('SELECT * FROM menu WHERE city = ?', session[:city])
   end
   @arr = Array.new
  @results.each do |item|
      if (@arr.index item[1]) == nil
          @arr.push(item[1])
      end
  end
  erb :index
end

get '/about' do
  if session[:login] then
    redirect "#{session[:permission]}/about"
  end
  erb :about
end

get '/contactPage' do
    erb :contactPage
end
get '/signIn' do
  if session[:login] then
    redirect "#{session[:permission]}/signIn"
  end
  erb :signIn
end
get '/signUp' do
  if session[:login] then
    redirect "#{session[:permission]}/signUp"
  end
  erb :"signUp"
end