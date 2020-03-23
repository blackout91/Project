require 'minitest/autorun'
require_relative '../main.rb'
require_relative '../ruby/defsAdmin.rb'

class TestAdminDefs < MiniTest::Test
    
    def test_updateUsers
        @db = SQLite3::Database.new '../public/db'
        #because method updateTable does not return anything,
        
    end
end