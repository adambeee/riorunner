class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    if params[:tag]
      #@search = Task.search do
      #fulltext params[:search]
      #with(:status).equal_to 'open'
      #end
      #@tasks = @search.results.tagged_with(params[:tag]).where(:status => 'open').paginate(:per_page => 5, :page => params[:page])
      @tasks = Task.all.tagged_with(params[:tag]).where(:status => 'open').paginate(:per_page => 9, :page => params[:page])
    else
      #@search = Task.search do
      # fulltext params[:search]
      #end
      #@tasks = @search.results
      @tasks = Task.all.where(:status => 'open').paginate(:per_page => 9, :page => params[:page])
    end
  end

  def update_autotask_with_runner
    @task = Task.find(params[:id])
    @user = User.find(@task.wallet_id)
    @task.update_attributes(:runner_id => current_user.id, :status => "pending payment")
    respond_to do |format|
      if @task.save
        Message.create(:sender_id => current_user.id, :recipient_id => @user.id, :subject => "#{User.find(current_user).first_name} #{User.find(current_user).last_initial} has accepted your task",
                       :body => "Please provide payment information #{view_context.link_to("here",task_path(@task))}".html_safe, :task_id => @task.id, :message_type => "confimation")
        format.html { redirect_to myriorunner_path(current_user), notice: 'Awaiting confirmation from wallet' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { redirect_to :back, notice: 'Something went wrong here' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def task_completion
    @task = Task.find(params[:id])
    @task.update_attribute(:status, "in progress")
    respond_to do |format|
      if @task.save
        Message.create(:sender_id => current_user.id, :recipient_id => @task.runner_id, :subject => "this is temporary",
                       :body => "This is temporary", :task_id => @task.id, :message_type => "confimation")
        format.html { redirect_to task_notes_path(@task), notice: 'You have provided successful payment information, please provide your runner with more job details' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { redirect_to :back, notice: 'Something went wrong here' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end



  end



  def show
    @task = Task.find(params[:id])
    @message = Message.new
    @task.update_attribute(:views, "#{@task.viewcalc}")
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end
  def my_tasks
    @user = User.find(params[:id])
    @tasks = @user.tasks.all
  end

  # GET /tasks/1/edit
  def edit
  end


  def update_task_with_runner
    @message = Message.find(params[:id])
    @task = Task.find(@message.task_id)
    @runner = User.find(@message.sender_id)
    @wallet = User.find(@task.wallet_id)
    @task.update_attributes(:runner_id => @runner, :price => @message.proposed_price)

    #task.update_attribute(:runner_id => message.sender_id, :price => message.proposed_price)
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.wallet_id = current_user.id


    respond_to do |format|
      if @task.save
        format.html { redirect_to myriorunner_path(current_user.id), notice: 'Task was Posted Correctly' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to myriorunner_path(current_user.id), notice: 'Task was deleted' }
      format.json { head :no_content }
    end
  end

  def tags
    @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?" , "%#{params[:q]}%")
    respond_to do |format|
      format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name}}}
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  #def task_params
  # params[:task]
  #end
  def task_params
    params.require(:task).permit(:wallet_id, :id, :subject, :description, :deliverables, :zipcode, :rating_required, :no_ratings_required, :price, :content, :tag_list, :task_category)
  end



end
