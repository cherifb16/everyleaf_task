class TasksController < ApplicationController
  helper_method :sort_direction
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = if params[:term]
      Task.where('name LIKE ? or state LIKE ?',"%#{params[:term]}%","%#{params[:term]}%").page params[:page]
    elsif params[:term1]
        Task.where('state LIKE ?', "%#{params[:term1]}%").page params[:page]  
    elsif params[:term3]
      Task.joins(:labels)
      .where("labels.title ILIKE ?", "%#{params[:term3]}%").page params[:page]        
    else
      @tasks = Task.order_list(params[:sort_by]).page params[:page]
      # @tasks = Task.all.order('created_at desc').page params[:page]
    end
  end

  def search
    @task =task.search(params[:search])
  end
  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @task.user_id = current_user.id
    @task.labels.build
    @task.tasks_labels.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @labels= Label.all
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :details, :state, :priority, :end_date, :term, :term1, :user_id, label_ids: [])
    end
end
