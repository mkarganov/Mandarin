require 'spec_helper'

describe ApplicationController do
  let(:user) { User.create(:name => 'Maks1', :email => 'maks1@test.com', :password  => '123') }

  it "should return current user" do
    session[:user_id] = user.id
    subject.send(:current_user).should_not be_nil
  end

end
