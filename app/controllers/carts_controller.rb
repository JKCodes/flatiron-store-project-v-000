class CartsController < ApplicationController
  before_action :set_cart, only: [:show]

  def show
  end

  def checkout
    cart = Cart.find(params[:id])
    cart.checkout
    redirect_to cart_path(cart)
  end

  private

    def set_cart
      @cart = Cart.find(params[:id])
    end
end
