class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to users_url
    else
      render :new
    end
  end

  def create
    # debugger
    @user = User.find_by(email: session_params[:email])
    if @user.is_password?(session_params[:password])
      login!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = "Invalid credentials"
      render :new
    end
  end

  def destroy
    @user = User.find_by(session_token: session[:session_token])
    @user.reset_session_token!
    session[:session_token] = nil
    redirect_to users_url
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
