require 'spec_helper'

describe SessionsController do

  before(:each) do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  end

  let(:user) { User.create(:name => 'Maks', :email => 'maks@test.com') }
  let(:auth) { user.authorizations.create(:provider => 'twitter', :uid => '1234') }

  context "GET create" do
    it "should add new provider for signed in user" do
      session[:user_id] = user.id
      expect {get :create, :provider => "twitter"}.to change { Authorization.count }.by(1)
    end

    it 'sign up already registered user' do
      get :create, :provider => auth.provider
      response.should redirect_to(root_path)
      flash[:notice].should_not be_nil
    end

    it 'creates new user from auth hash' do
      get :create, :provider => 'twitter'
      response.should redirect_to(edit_user_path(assigns[:auth].user))
    end
  end

  context 'DELETE destroy' do
    before :each do
      session[:user_id] = user.id
      delete :destroy
    end
    it 'removes the session' do
      session[:user_id].should be_nil
    end
    it 'sets the falsh' do
      flash[:notice].should_not be_nil
    end
    it 'redirects to root url' do
      response.should redirect_to(root_url)
    end
  end

end
