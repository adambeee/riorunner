module ApplicationHelper
  def title
    base_title = "RR Project - Coming Soon!!!"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  def logo
    image_tag("RRMockLogo.png", :alt => "Logo Will Go Here", :class => "round")
  end
  # Everything from here is for allowing devise to use resources to log in from the homepage.
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  #end of devise home page login.
end
