class TransactionsController < ApplicationController

	def create
		book = Book.find_by!(slug: params[:slug])
		token = params[:stripeToken]

		begin
			charge = Stripe::Charge.create(
   				 :customer    => customer.id,
   				 :amount      => book.price,
    			 :description => current_user.email,
   				 :currency    => 'usd',
   				 :card        => token
  			)

  			@sale = book.sales.create!(buyer_email: current_user.email)
  			redirect_to pickup_url(guid: @sale.guid)

		rescue Stripe::CardError => e
			@error = e
			redirect_to book_path(book), notice: @error			
		end

	end

	def pickup
		@sale = Sale.find_by!(guid: params[:slug])
		@book = @sale.book
	end
end