class LineItemsController < ApplicationController
  def create
    current_user.create_current_cart if !current_user.current_cart
    line_item = current_user.current_cart.add_item(params[:item_id])
    if line_item.save
      redirect_to cart_path(current_user.current_cart), notice: "Requested item was added to your cart."
    else
      redirect_to :back, notice: "Request item could not be added to your cart."
    end
  end
end
