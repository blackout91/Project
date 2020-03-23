require 'minitest/autorun'
require_relative '../main.rb'
require_relative '../ruby/defsEmployee.rb'

class TestEmployeeDefs < MiniTest::Test
    
    def test_getIndexFromTable
        @db = SQLite3::Database.new '../public/db'
        #cleaning up before testing
        @db.execute("DELETE FROM basket")
        @db.execute("DELETE FROM orders")
        #testing basket table
        assert_equal 0, getIndexFromTable("basket", "basketIndex")
        @db.execute('INSERT INTO basket VALUES (0, 2, 3.99)')
        assert_equal 1, getIndexFromTable("basket", "basketIndex")
        
        @db.execute('INSERT INTO basket VALUES (1, 2, 3.99)')
        @db.execute('INSERT INTO basket VALUES (2, 2, 3.99)')
        assert_equal 3, getIndexFromTable("basket", "basketIndex")
        
        @db.execute('DELETE FROM basket WHERE basketIndex = 1')
        index = getIndexFromTable("basket","basketIndex")
        @db.execute("INSERT INTO basket VALUES ('#{index}', 7, 4.99 )")
        index = getIndexFromTable("basket", "basketIndex")
        @db.execute("INSERT INTO basket VALUES ('#{index}', 7, 4.99 )")
        assert_equal 5, getIndexFromTable("basket", "basketIndex")
        
        #testing orders table
        assert_equal 0, getIndexFromTable("orders", "orderID")
        index = getIndexFromTable("orders", "orderID")
        puts(index)
        @db.execute("INSERT INTO orders VALUES (#{index}, 5, 3, 3.99,'pending', 5, 'leeds' )")
        assert_equal 1, getIndexFromTable("orders", "orderID")
        index = getIndexFromTable("orders", "orderID")
        @db.execute("INSERT INTO orders VALUES (#{index}, 5, 3, 3.99,'pending', 5, 'leeds' )")
        @db.execute("DELETE FROM orders WHERE orderID = 0 ")
        assert_equal 2, getIndexFromTable("orders", "orderID")
        
    end
    
end