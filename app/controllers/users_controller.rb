class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find( params[:id] )
  end
  
  def destroy
    @user = current_user
    customer = Stripe::Customer.retrieve(@user.stripe_customer_token)
    customer.cancel_subscription()
    if @user.destroy
      flash.alert = "Your subscription and account has been cancelled successfully!"
      redirect_to root_path
    end
  end
end