require 'spec_helper'

describe User do
  let(:user) { User.new(:name => "Maks", :email => 'maks@test.com', :password => '123', :password_confirmation => '123') }


  it "should have a name and email" do
    user.save
    user.name.should == "Maks"
    user.email.should == 'maks@test.com'
  end
  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it 'Should have encrypted password' do
    user.encrypt_password
    user.password_salt.should_not be nil
    user.password_hash.should_not be nil
  end

  it 'Should be authenticated' do
    user.save
    User.authenticate(user.email, user.password).should_not be nil
  end
end
