class ErCrm::CustomersController < ErCrm::ApplicationController
  def index
    @customers = ErCrm::Customer.all#includes([:country, :region, :owner_user, :user])

    respond_to do |format|
      format.html
    end
  end

  def show
    @customer = ErCrm::Customer.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @customer = ErCrm::Customer.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @customer = ErCrm::Customer.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def create
    @customer = ErCrm::Customer.new(permitted_params)

    begin
      @customer.save!
      redirect_to customers_path
    rescue ActiveRecord::RecordInvalid => e
      render :action => :new
    end
  end

  def update
    @customer = ErCrm::Customer.find(params[:id])
    @customer.attributes = permitted_params

    begin
      @customer.save!
      redirect_to customer_path(@customer)
    rescue ActiveRecord::RecordInvalid => e
      render :action => :edit
    end
  end

  def destroy
    @customer = ErCrm::Customer.find(params[:id])
    @customer.destroy

    redirect_to customers_path
  end

  def update_single_attribute
    @customer = ErCrm::Customer.find(params[:id])
    attribute_name = params[:attribute_name].to_sym
    attribute_value = params[:attribute_value]

    @customer.attributes = {attribute_name => attribute_value}
    
    respond_to do |format|
      format.js do
        begin
          @customer.save!
          render :partial => "update_single_attribute.js.erb", :locals =>{
            :attribute_name => attribute_name.to_s,
            :attribute_value => attribute_value
          }
        rescue ActiveRecord::RecordInvalid => e
          render :text => "<span class='help-block js-error'>#{@customer.errors[attribute_name].first}</span>"
        end
      end
    end
  end

  private
  def permitted_params
    params.require(:customer).permit(:email, :first_name, :last_name, :home_phone, :work_phone, :mobile_number, 
                                     :fax_number, :source_id, :region_id, :country_id, :city, :zip_code, 
                                     :street_address, :created_by_user_id, :customer_user_id)
  end
end

