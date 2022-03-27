class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :authenticate_admin!, except: [:create]

  # GET /users
  def index
    @users = User.all.sort
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  def edit; end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      create_feedback(@user.id, params[:message])
    else
      render json: { status: 400, data: { message: @user.errors } }, status: :bad_request
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: { status: 201, message: 'Feedback was successfully updated.', data: @user }, status: :created
    else
      render json: { status: 400, data: { message: @user.errors } }, status: :bad_request
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:fullname, :email, :phone)
  end

  def create_feedback(id, message)
    @feedback = Feedback.new
    @feedback.user_id = id
    @feedback.message = message
    if @feedback.save
      render json: { status: 201, message: 'Feedback was successfully send.', data: { user: @user, feedback: @feedback } }, status: :created
    else
      @user.destroy
      render json: { status: 400, data: { message: @feedback.errors } }, status: :bad_request
    end
  end
end
