require 'spec_helper'

page_contents = { Home:  {content: "Sample App", title: "Ruby on Rails Tutorial Sample App | Home"},
                  Help:  {content: "Help", title: "Ruby on Rails Tutorial Sample App | Help"},
                  About: {content: "About Us", title: "Ruby on Rails Tutorial Sample App | About Us"}
                }
describe "Static pages" do
  
  page_contents.each do |page_name, page_attrs|

    describe "#{page_name.to_s} page" do
  
      page_attrs.each do |page_attr, attr_content|
        it "should have the #{page_attr.to_s} '#{attr_content}'" do
          visit "/static_pages/#{page_name.to_s.downcase}" 
          eval( "expect(page).to have_#{page_attr.to_s}(attr_content)" )
        end
      end
    end
  end
end