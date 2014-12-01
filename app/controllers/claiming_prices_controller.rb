class ClaimingPricesController < ApplicationController
  before_action :set_claiming_price, only: [:show, :edit, :update, :destroy]

  def index
    @claiming_prices = ClaimingPrice.all
    respond_with(@claiming_prices)
  end

  def show
    respond_with(@claiming_price)
  end

  def new
    @claiming_price = ClaimingPrice.new
    respond_with(@claiming_price)
  end

  def edit
  end

  def create
    @claiming_price = ClaimingPrice.new(claiming_price_params)
    @claiming_price.save
    respond_with(@claiming_price)
  end

  def update
    @claiming_price.update(claiming_price_params)
    respond_with(@claiming_price)
  end

  def destroy
    @claiming_price.destroy
    respond_with(@claiming_price)
  end

  private
    def set_claiming_price
      @claiming_price = ClaimingPrice.find(params[:id])
    end

    def claiming_price_params
      params[:claiming_price]
    end
end
