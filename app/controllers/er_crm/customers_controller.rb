module ErCrm
  class CustomersController < ApplicationController
    def index
      @customers = Customer.all#includes([:country, :region, :owner_user, :user])
  
      respond_to do |format|
        format.html
      end
    end
  
    def show
      @customer = Customer.find(params[:id])
  
      respond_to do |format|
        format.html
      end
    end
  
    def new
      @customer = Customer.new
  
      respond_to do |format|
        format.html
      end
    end
  
    def edit
      @customer = Customer.find(params[:id])

      respond_to do |format|
        format.html
      end
    end
  
    def create
      @customer = Customer.new(permitted_params)
  
      begin
        @customer.save!
        redirect_to customers_path
      rescue ActiveRecord::RecordInvalid => e
        render :action => :new
      end
    end
  
    def update
      @customer = Customer.find(params[:id])
      @customer.attributes = permitted_params

      begin
        @customer.save!
        redirect_to customer_path(@customer)
      rescue ActiveRecord::RecordInvalid => e
        render :action => :edit
      end
    end
  
    def destroy
      @customer = Customer.find(params[:id])
      @customer.destroy

      redirect_to customers_path
    end

    private
    def permitted_params
      params.require(:customer).permit(:email, :first_name, :last_name, :phone, :source_id, :region_id, :country_id, 
                                       :city, :zip_code, :street_address, :created_by_user_id, :customer_user_id)
    end

  end
end
