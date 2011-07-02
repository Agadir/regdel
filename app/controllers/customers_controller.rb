class CustomersController < ApplicationController
  def index
    @customers = Customer.find(:all)
  end
  def new
    @customer = Customer.new
  end
  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      redirect_to customers_path
    end
  end
  def show
    @customer = Customer.find(params[:id])
  end
  def edit
    @customer = Customer.find(params[:id])
  end
  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(@customer)
      redirect_to customers_path
    end
  end
end
