class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.authenticate_with_credentials(params[:email], params[:password])

    if @user
      cookies.encrypted[:user_session] = {
        value: @user.id,
        expires: 5.days.from_now
      }
      redirect_to :root
    else
      render :new
    end
  end

  def destroy
    cookies.delete :user_session
    redirect_to :root
  end
end
