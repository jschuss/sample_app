require 'spec_helper'

describe "User pages" do

  page_contents = { SignUp: { heading: "Sign up",
                              title: "Sign up" },
                    SignIn: { heading: "Sign in",
                              title: "Sign in" }
                  }


  shared_examples_for "all user pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title full_title(title) }
  end

  page_contents.each do |page_name, page_attrs|
    page_name = page_name.to_s

    subject { page }

    describe "#{page_name} page" do
      page_name.downcase!

      before { visit eval( "#{page_name}_path" ) }

      page_attrs.each do |page_attr, attr_content|
        let(page_attr.to_sym) { attr_content }
      end

      it_should_behave_like "all user pages"

    end
  end
end