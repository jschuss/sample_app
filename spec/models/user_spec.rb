require 'spec_helper'

describe User do

  before(:each) {
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar") }

  invalid_emails = %w[userr@@foo.com user_at_foo.org example.user@foo.
                      foo@barbaz..com foo@bar+baz.com]
  valid_emails =   %w[foo@barbaz.com user@foo.COM A_US-ER@f.b.org
                      frst.lst@foo.jp a+b@baz.cn]

  fail_modes = { not_present:    { name:     " ",
                                   email:    " ",
                                   password: " " },
                 too_long:       { name:     long(:name),
                                   email:    long(:email) },
                 too_short:      { password: "a"*5 },
                 invalid_format: { email:    invalid_emails },
                 not_unique:     { email:    'some_other_guy@has_this.email' },
                 not_matching:   { password: 'fooFOO1',
                                   pass_con: 'barBAR2' }
               }

  pass_modes = { valid_format:   { email:    valid_emails },
                 is_matching:    { password: 'matching'}
               }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate) }

  it { should be_valid }

  #failing checks
  fail_modes.each do |fail_mode, fail_attrs|
    fail_mode = fail_mode.to_s.gsub('_', ' ')

    fail_attrs.each do |fail_attr, fail_val|
      fail_attr = :password_confirmation if fail_attr == :pass_con


      describe "when #{fail_attr.to_s} is #{fail_mode}" do

        it "should not be valid" do

          if fail_mode == 'not unique'
            some_other_guy = @user.dup
            some_other_guy.email = fail_val
            some_other_guy.save
          end

          fail_val = [fail_val] unless fail_val.is_a? Array
          while (val = fail_val.pop)

            if fail_mode == 'not present' && fail_attr == :password

              @user = User.new(name: "Example User", email: "user@example.com",
                               password: val, password_confirmation: val)

            else

              @user.update_attribute(fail_attr, val)

              pass_no_match = @user.password != @user.password_confirmation
              if pass_no_match && fail_mode != 'not matching'
                @user.update_attribute(:password_confirmation, @user.password)
              end
            end

            expect(@user).to_not be_valid

          end
        end
      end
    end
  end

  #passing checks
  pass_modes.each do |pass_mode, pass_attrs|
    pass_mode = pass_mode.to_s.gsub('_', ' ')

    pass_attrs.each do |pass_attr, pass_val|
      pass_attr = :password_confirmation if pass_attr == :pass_con


      describe "when #{pass_attr.to_s} is #{pass_mode}" do

        it "should be valid" do

          pass_val = [pass_val] unless pass_val.is_a? Array
          while (val = pass_val.pop)

            @user.update_attribute(pass_attr, val)

            pass_no_match = @user.password != @user.password_confirmation
            if pass_no_match
              @user.update_attribute(:password_confirmation, @user.password)
            end

            expect(@user).to be_valid

          end
        end
      end
    end
  end

  #authentication checks
  describe "return value of authenticate method" do
  before { @user.save }
  let(:found_user) { User.find_by(email: @user.email) }

  describe "with valid password" do
    it { should eq found_user.authenticate(@user.password) }
  end

  describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not eq user_for_invalid_password }
    specify { expect(user_for_invalid_password).to be_false }
  end
end
end