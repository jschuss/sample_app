require 'spec_helper'

describe "User pages" do
  
  page_contents = { SignUp: { content: "Sign up",
                              title: full_title("Sign up") },
                    SignIn: { content: "Sign in",
                              title: full_title("Sign in") }
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