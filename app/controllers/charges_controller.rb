class ChargesController < ApplicationController
  before_action :authenticate_user!

  def create
     # with the charge
     customer = Stripe::Customer.create(
       email: current_user.email,
       card: params[:stripeToken]
     )

     # Where the real magic happens
     charge = Stripe::Charge.create(
       customer: customer.id, # Note -- this is NOT the user_id in your app
       amount: 15_00,
       description: "doUpedia Premium Membership - #{current_user.email}",
       currency: 'usd'
     )

     current_user.premium!
     current_user.wikis.update_all(private: true)
     
     flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
     redirect_to user_unlock_path

     # Stripe will send back CardErrors, with friendly messages
     # when something goes wrong.
     # This `rescue block` catches and displays those errors.
     rescue Stripe::CardError => e
       flash[:alert] = e.message
       redirect_to new_charge_path
   end

   def new
      @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "doUpedia Premium Membership - #{current_user.name}",
      amount: 15_00
    }
  end
end
