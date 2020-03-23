def getIndexFromTable(table, column)
    
    index = @db.get_first_value("SELECT MAX(#{column}) FROM #{table}")
    if index.nil? 
        index = 0  
    else
        index = index+1
    end
    return index
end