post '/admin/addMenu' do
    @results = @db.execute('SELECT * FROM menu')
    @submitted = false
    #sanitize values
    @item = params[:item].strip
    @size = params[:size].strip
    @price = params[:price].strip
    @city = params[:city].strip

    #perform validation
    @item_ok = !@item.nil? && @item != ""
    @size_ok = !@size.nil? && @size != ""
    @price_ok = @price =~ /^[+-]?\d+(\.\d+)?$/ && @price >= '0' && !@price.nil?
    count = @db.get_first_value('SELECT COUNT(*) FROM menu WHERE item = ? AND size = ? AND city = ?',[@item, @size, @city])
    @unique = (count == 0)
    @all_ok = @item_ok && @size_ok && @price_ok && @unique

    #add data to the database
    if @all_ok
        #get next available ID
        @itemID = @db.get_first_value('SELECT COUNT(*) FROM menu')

        #do the insert
        @db.execute(
            'INSERT INTO menu VALUES (?, ?, ?, ?, ?)',
            [@itemID, @item, @size, @price, @city])
    else
        @submitted = true
    end

    redirect '/admin/menu' 
end

post '/admin/changeMenu' do
    @itemID = params[:itemID]
    @item = params[:item].strip
    @size = params[:size]
    @price = params[:price].strip
    @city = params[:city].strip
    
    count = @db.get_first_value('SELECT COUNT(*) FROM menu WHERE item = ? AND size = ? AND city = ?',[@item, @size, @city])
    @unique = (count == 0)
    
    #Sanitisation
    @item_ok = !@item.nil? && @item != ""
    @city_ok = !@city.nil? && @city != ""
    @price_ok = @price =~ /^[+-]?\d+(\.\d+)?$/ && !@price.nil? && @price != ""
    
    #Inputting to database
    if @item_ok && @unique
       @db.execute('UPDATE menu SET item = ? WHERE itemID = ?',
            [@item, @itemID]) 
    end
    if @unique
       @db.execute('UPDATE menu SET size = ? WHERE itemID = ?',
            [@size, @itemID]) 
    end
    if @price_ok
       @db.execute('UPDATE menu SET price = ? WHERE itemID = ?',
            [@price, @itemID]) 
    end
    if @city_ok && @unique
       @db.execute('UPDATE menu SET city = ? WHERE itemID = ?',
            [@city, @itemID]) 
    end
    redirect '/admin/menu' 
    
end

post '/admin/removeMenu' do
    @itemID = params[:ID].strip
    @db.execute('DELETE FROM menu WHERE itemID = (?)',[@itemID])
    redirect '/admin/menu'
    puts "Hello"
end

#Change user details
post '/admin/updateDetails' do
    @index = params[:userID]
    @firstname = params[:firstname].strip
    @lastname = params[:lastname].strip
    @address = params[:address].strip
    @email = params[:email].strip
    @homephone = params[:homephone].strip
    @mobphone = params[:mobphone].strip
    @handle = params[:handle].strip
    @password = params[:password]
    @city = params[:city]
    @offer = params[:offer]
    @permission = params[:permission].strip
    
    #Counts
    @email_count = @db.get_first_value('SELECT COUNT(*) FROM users WHERE email = ?',[@email])
    @handle_count = @db.get_first_value('SELECT COUNT(*) FROM users WHERE handle = ?',[@handle])
    
    #Sanitisation
    @firstname_ok = !@firstname.nil? && @firstname != ""
    @lastname_ok = !@lastname.nil? && @lastname != ""
    @address_ok = !@address.nil? && @address != ""
    @email_ok = !@email.nil? && @email != "" && (@email_count == 0)
    @homephone_ok = !@homephone.nil? && @homephone != ""
    @mobphone_ok = !@mobphone.nil? && @mobphone != ""
    @handle_ok = !@handle.nil? && @handle != "" && (@handle_count == 0)
    @password_ok = !@password.nil? && @password != "" 
    #Inputting to database
    if @firstname_ok
        @db.execute(
            'UPDATE users SET firstname = ? WHERE userID = ?',
            [@firstname, @index]
        )
    end
    if @lastname_ok
        @db.execute(
            'UPDATE users SET lastname = ? WHERE userID = ?',
            [@lastname, @index]
        )
    end
    if @address_ok
        @db.execute(
            'UPDATE users SET address = ? WHERE userID = ?',
            [@address, @index]
        )
    end
    if @email_ok
        @db.execute(
            'UPDATE users SET email = ? WHERE userID = ?',
            [@email, @index]
        )
    end
    if @homephone_ok
        @db.execute(
            'UPDATE users SET homephone = ? WHERE userID = ?',
            [@homephone, @index]
        )
    end
    if @mobphone_ok
        @db.execute(
            'UPDATE users SET mobphone = ? WHERE userID = ?',
            [@mobphone, @index]
        )
    end
    if @handle_ok
        @db.execute(
            'UPDATE users SET handle = ? WHERE userID = ?',
            [@handle, @index]
        )
    end
    if @password_ok
        @db.execute(
            'UPDATE users SET password = ? WHERE userID = ?',
            [@password, @index]
        )
    end
    
    @db.execute(
            'UPDATE users SET city = ?, permission = ?, offers = ? WHERE userID = ?',
            [@city, @permission, @offer, @index]
        )
    session[:city] = @city
    redirect '/admin/changeCustomer'

end
post '/admin/removeUser' do
    @userID = params[:ID].strip
    @permission = params[:permission].strip
    
    if @permission != "admin"
        @db.execute('DELETE FROM users WHERE userID = (?)',[@userID])
    end
    redirect '/admin/changeCustomer'
end

post '/filterClients' do
    @filter = params[:filter]
    
    if !@filter.nil?
        if @filter == "all"
            @results = @db.execute("SELECT * FROM users")
        else
            @results = @db.execute("SELECT * FROM users WHERE permission = '#{params[:filter]}'")
        end
    end
    erb :"admin/printClientDetails"
end
