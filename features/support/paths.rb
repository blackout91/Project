module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #

  def path_to(page_name)
    case page_name

   when /the home\s?page/
      '/home'
   when /the home\s?page after back to top/
      '/home#'
   when /the signin page/
      '/signIn'
   when /the signup page/
      '/signUp'
   when /the default signup page/
      '/signup'
   when /the about us page/
      '/about'
   when /the contact us page/
      '/contactPage'
        
        
   when /the user home\s?page/
      '/user/home'
   when /the menu page of user/
      '/user/menu'
   when /the offer page of user/
      '/user/offers'
   when /the details page of user/
      '/user/details'
        
   when /the home\s?page of employee/
      '/employee/home'    
   when /the tweet page of employee/
      '/employee/tweet'
   when /the order page of employee/
      '/employee/order'
   when /the change offers page of employee/
      '/employee/changeOffers'
        
   when /the home\s?page of admin/
      '/admin/home'
   when /the tweet page of admin/
      '/admin/tweet'
   when /the order page of admin/
      '/admin/order'
   when /the change offers page of admin/
      '/admin/changeOffers'
   when /the change menu page of admin/
      '/admin/menu'
   when /the change customer page of admin/
      '/admin/changeCustomer'
   when /the analytics page of admin/
      '/admin/analytics'
   when /the history of order page of admin/
      '/admin/history'
        
   when /the filterByCity page/
      '/filterByCity'
   when /the addOrder page/
      '/addOrder'
        
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"

    end
  end
end

World(NavigationHelpers)