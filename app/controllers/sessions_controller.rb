class SessionsController < ApplicationController

  skip_before_filter :require_email, :only => :destroy

  def new
  end

 def create
  auth_hash = request.env['omniauth.auth']
    if session[:user_id]
      # Means our user is signed in. Add the authorization to the user
      User.find(session[:user_id]).add_provider(auth_hash)

      # render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
    else
        # Log him in or sign him up
      if @auth = Authorization.find_by_auth(auth_hash).first
        raise "#{@auth.inspect}"
        redirect_to root_url
        flash[:notice] = "Welcome back #{@auth.user.name}"
      # Create the session
        session[:user_id] = @auth.user.id
      else
        @auth = Authorization.create_(auth_hash)
        redirect_to edit_user_url(@auth.user)
      end
      session[:user_id] = @auth.user.id
    end
    @user = User.find(session[:user_id]).name
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to root_url
  end

end
