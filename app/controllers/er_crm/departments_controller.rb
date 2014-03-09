class ErCrm::DepartmentsController < ErCrm::ApplicationController
  def index
    @departments = ErCrm::Department.includes(:lead_category)

    respond_to do |format|
      format.html
    end
  end

  def new
    @department = ErCrm::Department.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @department = ErCrm::Department.new(permitted_params)

    begin
      @department.save!
      redirect_to departments_path
    rescue ActiveRecord::RecordInvalid => e
      render :action => :new
    end
  end

  def show
    @department = ErCrm::Department.includes(:lead_category).find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def edit
    @department = ErCrm::Department.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def update
    @department = ErCrm::Department.find(params[:id])
    @department.attributes = permitted_params

    begin
      @department.save!
      redirect_to department_path(@department)
    rescue ActiveRecord::RecordInvalid => e
      render :action => :edit
    end
  end

  def destroy
    @department = ErCrm::Department.find(params[:id])
    @department.destroy

    redirect_to departments_path
  end

  private
  def permitted_params
    params.require(:department).permit(:id, :name, :category_id)
  end
end