require 'spec_helper'

## Returns the full title on a per-page basis.
#def full_title(page_title = nil)
#  base_title = "Ruby on Rails Tutorial Sample App"
#  if page_title.empty? || page_title.nil?
#    base_title
#  else
#    "#{base_title} | #{page_title}"
#  end
#end

describe "Static pages" do
  
  page_contents = { Home:    { content: "Sample App",
                               title: full_title()         },
                    Help:    { content: "Help",
                               title: full_title("Help")     },
                    About:   { content: "About Us",
                               title: full_title("About Us") },
                    Contact: { content: "Contact",
                               title: full_title("Contact")  }
                  }

  
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