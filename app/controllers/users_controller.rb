class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, except: [:show, :new, :create]

  def index
    if params[:search]
      @users = User.search(params[:search]).order("last_name ASC")
    else
      @users = User.all
    end    
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to root_path, :alert => "Access denied."
      end
    end
  end

 def edit
    @user = User.find(params[:id])
    authorize @user
    unless current_user.admin?
      unless @user == current_user
        redirect_to root_path, :alert => "Access denied."
      end
    end
  end

  def new
    if current_user.admin?
      @newuser = User.new
    else
        redirect_to root_path, :alert => "Access denied."
    end
  end

  def create
    if current_user.admin?
      @newuser = User.new(:email => secure_params[:email], :password => secure_params[:password], :first_name => secure_params[:first_name], :last_name => secure_params[:last_name], :phone => secure_params[:phone], :role => secure_params[:role])
      if @newuser.save
        flash[:notice] = "Successfully created User." 
        redirect_to users_path
      else
        render :action => 'new'
      end
    else
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def update
    @user = User.find(params[:id])

    authorize @user
    if @user.update_attributes(secure_params)
      @user.save
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role, :first_name, :last_name, :phone, :email, :password, :password_confirmation)
  end

end
