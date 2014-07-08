FactoryGirl.define do
  factory :user do
    name     "Jeff Schuss"
    email    "jschuss@seniorssp.com"
    password "foobar"
    password_confirmation "foobar"
  end
end