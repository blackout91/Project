require 'minitest/autorun'
require_relative 'main.rb'

class TestMain < Minitest::Test
	
	def test_main_tweets_1
		
		m = Main.new(tweet,order,tweet)
		assert_equal 1, t.get_tweet(0)
		assert_equal 2, t.get_tweet(1)
		assert_equal 3, t.get_tweet(2)
	end