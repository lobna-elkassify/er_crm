class ErCrm::LeadTypesController < ErCrm::ApplicationController
  def index
    @lead_types = ErCrm::LeadType.includes(:lead_category)

    respond_to do |format|
      format.html
    end
  end

  def show
    @lead_type = ErCrm::LeadType.includes(:lead_category).find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @lead_type = ErCrm::LeadType.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @lead_type = ErCrm::LeadType.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def create
    @lead_type = ErCrm::LeadType.new(permitted_params)

    begin
      @lead_type.save!
      redirect_to lead_types_path
    rescue ActiveRecord::RecordInvalid => e
      render :action => :new
    end
  end

  def update
    @lead_type = ErCrm::LeadType.find(params[:id])
    @lead_type.attributes = permitted_params

    begin
      @lead_type.save!
      redirect_to lead_type_path(@lead_type), notice: 'Lead Type was successfully updated.'
    rescue ActiveRecord::RecordInvalid => e
      render :action => :edit
    end
  end

  def destroy
    @lead_type = ErCrm::LeadType.find(params[:id])
    @lead_type.destroy

    redirect_to lead_types_path
  end

  private
  def permitted_params
    params.require(:lead_type).permit(:id, :name, :lead_category_id)
  end
end