class Purchase::CheckoutsController < ApplicationController
 before_action :authenticate_user!

  def create
    product = Stripe::Product.create({
  name: 'Your Product Name',
  description: 'Description of your product',
  images: ['https://example.com/product-image.png'],
})
price = Stripe::Price.create({
  unit_amount: 2000, # Amount in cents ($20.00)
  currency: 'usd',
  recurring: {interval: 'month'},
  product: product, # Replace with your product ID
})

    session = Stripe::Checkout::Session.create(
      customer: current_user.stripe_id,
      client_reference_id: current_user.id,
       customer_email: current_user.email,
      success_url: root_url,
      cancel_url: pricing_url,
      payment_method_types: ['card'],
      mode: 'subscription',
      customer_email: current_user.email,
      line_items: [{
        quantity: 1,
        price: price,
      }]
    )
    #render json: { session_id: session.id } # if you want a json response
    redirect_to session.url, allow_other_host: true
  end
  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @customer = Stripe::Customer.retrieve(session.customer)
  end
end