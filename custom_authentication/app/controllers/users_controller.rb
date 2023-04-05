class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :require_login?

  def root_page
  end

  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        UserMailer.with(user: @user).welcome_email.deliver_now
        format.html { redirect_to login_path, notice: "User was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(email: user_params[:email])
        UserMailer.with(user: @user).update_email.deliver_now
        format.html { redirect_to root_path, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def login
    @user = User.new
  end

  def log_in
    user = User.find_by(email: user_params[:email])
    if user
      if user.password = user_params[:password]
        flash[:notice] = "Successfully loged in."
        session[:current_user_id] = user.id
        redirect_to root_path
      else
        flash[:notice] = "Wrong credentials."
        redirect_to login_path
      end
    else
      flash[:notice] = "User does not exist."
      redirect_to login_path
    end
  end

  def logout
    session.clear
    cookies.delete(:name)
    redirect_to login_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :password, :remember_token, :avatar)
  end
end
