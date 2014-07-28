class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end
  def my_messages
    @user = User.find(params[:id])
    @messages = @user.messages.all
  end
  def rr_inbox
    @user = User.find(params[:id])
    @messages = @user.messages.where(:recipient_id => current_user.id, :message_status => ['unread', 'read']).paginate(:per_page => 10, :page => params[:page])
    @unread_messages = current_user.messages.where(:message_status => 'unread')
  end
  def rr_sent
    @user = User.find(params[:id])
    @messages = Message.where(:sender_id => current_user.id, :message_type => 'message').paginate(:per_page => 10, :page => params[:page])
    @unread_messages = current_user.messages.where(:message_status => 'unread')
  end
  def rr_deleted
    @user = User.find(params[:id])
    @messages = @user.messages.where(:recipient_id => current_user.id, :message_status => 'deleted').paginate(:per_page => 10, :page => params[:page])
    @unread_messages = current_user.messages.where(:message_status => 'unread')
  end

  def markasdeleted
    @message = Message.find(params[:id])
    @message.update_attribute(:message_status, "deleted")
    redirect_to mymessages_path(current_user)
  end

  def taskconfirmation
    @message = Message.find(params[:id])
    @user = User.find(@message.sender_id)
    @task = Task.find(@message.task_id)
    if @task.status == "open"
      @task.update_attributes(:price => @message.proposed_price, :status => "pending payment", :runner_id => @message.sender_id)
      redirect_to task_path(@task)
      if @task.save
        flash[:notice] = "Runner Notified"
        Message.create(:sender_id => current_user.id, :recipient_id => @user.id, :subject => "congrats, you are now the runner",
                       :body => "wait for contact from the seller, congrats", :task_id => @task.id, :message_type => "confimation")
      end
    else
      redirect_to inbox_path(current_user)
      flash[:error] = "Something went wrong"
    end
  end

  def show
    @message = Message.find(params[:id])
    @unread_messages = current_user.messages.where(:message_status => 'unread')
    if current_user.id == @message.sender_id || current_user.id == @message.recipient_id #makes sure people can't read other messages and be cute
      @user = User.find(@message.sender_id)
      @task = Task.find(@message.task_id)
      @message.update_attribute(:message_status, "read")
    else
      flash[:error] = "Invalid Page"
      redirect_to root_path
    end
  end

  #Working with mailboxes for messages
  def inbox

  end
  def sent

  end
  def deleted

  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to myriorunner_path(current_user.id), notice: 'Message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json


  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to mymessages_path(current_user.id) }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only a
  # llow the white list through.
  def message_params
    params[:message]
  end
end
