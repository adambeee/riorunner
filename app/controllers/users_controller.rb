class UsersController < ApplicationController

  def index
    @users = User.all # getting all the users!
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end
  def my_rio_runner
    @user = User.find(params[:id])
    @tasks = @user.tasks
    @messages = @user.messages
    @messages_unread = @user.messages.where(:message_status => 'unread')
  end
  def add_payment_info
    @user = User.find(current_user.id)
    @task = Task.find(params[:id])
  end
  def create
    @user = User.new(params[:user]) # Not the final implementation!
    if @user.save
      flash[:success] = "User Created Successfully"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])

  end
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Hate to see you go' }
      format.json { head :no_content }
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[user_params])
      flash[:notice] = 'User Updated.'
      redirect_to myriorunner_path(current_user)
    else
      render :back
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :first_name, :last_name, :email, :password, :password_confirmation, :about_me, :avatar)
  end
end
