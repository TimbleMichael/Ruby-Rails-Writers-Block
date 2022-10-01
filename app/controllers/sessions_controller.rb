class SessionsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        flash[:success] = "You have logged in"
        redirect_to questions_path
      else
        flash.now[:danger] = "There was something wrong with your login information"
        render 'new'
      end
    end

    def create_from_omniauth
      @user = 
        User.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.email = auth['info']['email']
        end

        session[:user_id] = @user.id

        render 'new'
    end
  
    def destroy
      session[:user_id] = nil
      flash[:success] = "You have logged out"
      redirect_to root_path
    end

    private

    def auth
      request.env['omniauth.auth']
    end
end