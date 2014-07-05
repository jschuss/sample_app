require 'spec_helper'

describe "Static pages" do

  page_contents = { Home:    { heading: "Engineering Wiki",
                               title: nil       },
                    Help:    { heading: "Help",
                               title: "Help"    },
                    About:   { heading: "About",
                               title: "About"   },
                    Contact: { heading: "Contact",
                               title: "Contact" }
                  }

  link_tests =    { Home:             { title: nil       },
                    Help:             { title: "Help"    },
                    About:            { title: "About"   },
                    Contact:          { title: "Contact" },
                    engineering_wiki: { title: nil       },
                    Sign_up_now!:     { title: "Sign up" }
                  }

  shared_examples_for "all static pages" do
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

      it_should_behave_like "all static pages"

    end
  end

  it "should have the right links on the layout" do
    visit root_path

    link_tests.each { |link_name, link_attrs|
                      click_link link_name.to_s.gsub('_', ' ')

      link_attrs.each { |link_attr, attr_content|
                        expect(page).to send("have_#{link_attr.to_s}".to_sym, attr_content) } }
  end

end