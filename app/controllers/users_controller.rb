class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy, :details]

  authorize_resource

  # GET /users
  # GET /users.json
  def index
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def me
    redirect_to :show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      params[:id] = current_user.id if params[:id] == "profile"
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if params[:user] and params[:user][:role] and params[:user][:role][:id]
        params[:user][:role_id] = params[:user][:role][:id]
      end

      params.require(:user).permit(:email, :first_name, :last_name, :role_id, :active)

    end
end
