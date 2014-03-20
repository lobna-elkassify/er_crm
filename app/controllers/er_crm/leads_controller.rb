class ErCrm::LeadsController < ErCrm::ApplicationController
  def index
    @leads = ErCrm::Lead.includes(:customer, :department, :lead_type, :follow_up)#.includes(:owner_user, :assigned_user)

    respond_to do |format|
      format.html
    end
  end

  def show
    @lead = ErCrm::Lead.includes(:customer, :department, :lead_type, :follow_up)#.includes(:owner_user, :assigned_user)
                       .find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @lead = ErCrm::Lead.new()
    @lead.customer_id = params[:customer_id] if params[:customer_id] 
    @lead.build_follow_up

    respond_to do |format|
      format.html
    end
  end

  def edit
    @lead = ErCrm::Lead.find(params[:id])
    @lead.build_follow_up if @lead.follow_up_id.nil?    

    respond_to do |format|
      format.html
    end
  end

  def create
    @lead = ErCrm::Lead.new(permitted_params)

    begin
      @lead.save!
      redirect_to leads_path
    rescue ActiveRecord::RecordInvalid => e
      render :action => :new
    end
  end

  def update
    @lead = ErCrm::Lead.find(params[:id])
    @lead.attributes = permitted_params

    begin
      @lead.save!
      redirect_to lead_path(@lead)
    rescue ActiveRecord::RecordInvalid => e
      render :action => :edit
    end
  end

  def destroy
    @lead = ErCrm::Lead.find(params[:id])
    @lead.destroy

    redirect_to leads_path
  end

  def permitted_params
    params.require(:lead).permit(:comments, :status_id, :department_id, :reservation_id, :customer_id, :lead_type_id,
                                 :follow_up_id, :created_by_user_id, :assigned_user_id,
                                 :follow_up_attributes => [:id, :datetime, :description, :_destroy])
  end
end