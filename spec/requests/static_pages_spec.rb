require 'spec_helper'

describe "Static pages" do
  
  page_contents = { Home:    { content: "Engineering Wiki",
                               title: full_title()          },
                    Help:    { content: "Help",
                               title: full_title("Help")    },
                    About:   { content: "About",
                               title: full_title("About")   },
                    Contact: { content: "Contact",
                               title: full_title("Contact") }
                  }

  
  page_contents.each do |page_name, page_attrs|
    page_name = page_name.to_s
    
    subject { page }
    
    describe "#{page_name} page" do
      page_name.downcase!
      
      before { visit eval( "#{page_name}_path" ) }
      
      page_attrs.each do |page_attr, attr_content|
        it { should send( "have_#{page_attr.to_s}".to_sym, attr_content) }
        
      end
    end
  end
end