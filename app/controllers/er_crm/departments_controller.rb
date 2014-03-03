class ErCrm::DepartmentsController < ErCrm::ApplicationController
  def index
    @departments = Department.all

    respond_to do |format|
      format.html
    end
  end

  def new
    @department = Department.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @department = Department.new(permitted_params)

    begin
      @department.save!
      redirect_to departments_path
    rescue ActiveRecord::RecordInvalid => e
      render :action => :new
    end
  end

  def show
    @department = Department.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def edit
    @department = Department.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def update
    @department = Department.find(params[:id])
    @department.attributes = permitted_params

    begin
      @department.save!
      redirect_to department_path(@department)
    rescue ActiveRecord::RecordInvalid => e
      render :action => :edit
    end
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    redirect_to departments_path
  end

  private
  def permitted_params
    params.require(:department).permit(:id, :name)
  end
end