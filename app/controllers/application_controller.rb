class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def cart
    # value = cookies[:cart] || JSON.generate({})
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

  def require_user
    if cookies.encrypted[:user_session].nil?
      render json: { errors: 'Could not find user' }, status: 400
    else
      @user = User.find(cookies.encrypted[:user_session])
      if @user
        true
      else
        render json: { errors: 'Could not find user' }, status: 400
      end
    end 
  end 
end
