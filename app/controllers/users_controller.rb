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
      if secure_params[:password] != secure_params[:password_confirmation]
        respond_to do |format|
          @newuser = User.new
          @newuser.email = secure_params[:email]
          @newuser.name = secure_params[:name]
          @newuser.phone = secure_params[:phone]
          @newuser.role = secure_params[:role]
          @newuser.errors.add(:password_confirmation, "does not match")
          format.html { render action: 'new', notice: "does not match"}
        end
      elsif secure_params[:password].empty?
        respond_to do |format|
          @newuser = User.new
          @newuser.email = secure_params[:email]
          @newuser.name = secure_params[:name]
          @newuser.phone = secure_params[:phone]
          @newuser.role = secure_params[:role]
          @newuser.errors.add(:password, "blank password")
          format.html { render action: 'new', notice: "blank password"}  
        end
      else
        @newuser = User.new(secure_params)
        if @newuser.save
          flash[:notice] = "Successfully created User." 
          redirect_to users_path
        else
          respond_to do |format|
          format.html { render action: 'new', notice: "blank password"}  
        end
        end
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
    params.require(:user).permit(:role, :name, :phone, :email, :password, :password_confirmation)
  end

end
