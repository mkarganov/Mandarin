class UsersController < ApplicationController

  skip_before_filter :require_email, :except => :show

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.valid?(:sign_up)
      @user.save
    end
  end

  def update
    @user = User.find(params[:id])
    if @user and @user.update_attributes(params[:user])
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
