require 'spec_helper'

describe UsersController do

let(:user) {User.create(:name => 'Maks', :email => "maks@test.com", :password => "123", :password_confirmation => "123")}
  context 'GET edit' do
    it 'should return @user' do
      get :edit, :id => user.id
      assigns[:user].should be_true
    end
  end

  context 'GET show' do
    it 'should show a user' do
      get :show, :id => user.id
      assigns[:user].should be_true
    end
  end

  context 'PUT update' do
    #it 'should find a user' do
      #get :update, :id => user.id
      #assigns[:user].should_not be_nil
    #end
    it 'should redirect to root page' do
      put :update, :id => user.id, :user => { :name => "Bob", :email => 'bob@test.com' }
      response.should redirect_to(root_url)
    end

    it 'should render edit template if params invalid' do
      put :update, :id => user.id, :user => { :email => "", :name => "" }
      response.should render_template(:edit)
    end
  end

  context 'GET new' do
    it 'should assign a new user' do
   xhr :get, :new, :user => { :name => 'Bob', :email => 'bob@test.com', :password => '123', :password_confirmation => '123' }, :remote => :true
   assigns[:user]
    end
  end

  context 'POST create' do
    it 'should create a new user from received params' do

    expect {xhr :post, :create, :user => { :name => 'Bob', :email => 'bob@test.com', :password => '123', :password_confirmation => '123' }}.to change { User.count }.by(1)
    end
  end

end
