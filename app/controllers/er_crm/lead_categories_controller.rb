class ErCrm::LeadCategoriesController < ErCrm::ApplicationController
  def index
    @lead_categories = ErCrm::LeadCategory.all

    respond_to do |format|
      format.html
    end
  end
  
  def new
    @lead_category = ErCrm::LeadCategory.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @lead_category = ErCrm::LeadCategory.new(permitted_params)

    begin
      @lead_category.save!
      redirect_to lead_categories_path
    rescue ActiveRecord::RecordInvalid => e
      render :action => :new
    end
  end

  def show
    @lead_category = ErCrm::LeadCategory.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def edit
    @lead_category = ErCrm::LeadCategory.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def update
    @lead_category = ErCrm::LeadCategory.find(params[:id])
    @lead_category.attributes = permitted_params

    begin
      @lead_category.save!
      redirect_to lead_category_path(@lead_category), notice: 'Lead Category was successfully updated.'
    rescue ActiveRecord::RecordInvalid => e
      render :action => :edit
    end
  end

  def destroy
    @lead_category = ErCrm::LeadCategory.find(params[:id])
    @lead_category.destroy

    redirect_to lead_categories_path
  end

  private
  def permitted_params
    params.require(:lead_category).permit(:id, :name)
  end
end
