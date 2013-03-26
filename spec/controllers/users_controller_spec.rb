require 'spec_helper'

describe UsersController do

let(:user) {User.create(:name => 'Maks')}
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
      put :update, :id => user.id
      response.should render_template('edit')
    end
  end

end
