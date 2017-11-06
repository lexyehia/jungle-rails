class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email]).authenticate(params[:password])

    if user
      cookies.encrypted[:user_session] = {
        value: user.id,
        expires: 5.days.from_now
      }
      redirect_to :root
    else
      render :new
    end
  end

  def destroy
  end
end
