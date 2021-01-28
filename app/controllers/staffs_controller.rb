class StaffsController < ApplicationController
  before_action :set_staff, only: %i[ show edit update destroy ]

  def index
    @search = Staff.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @staffs = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @staff
  end

  def new
    @staff = Staff.new
    @staff.initial_password = Passgen::generate(lowercase: :only, uppercase: false)
  end

  def edit
    @staff = Staff.find(params[:id])
    @user = @staff.user
  end

  def create
    @staff = Staff.new(staff_params)
    @staff.save!

    begin
      @user = User.new(user_params)
      @user.avatar.attach(params[:user][:avatar])
      @user.save!
    rescue
      @staff.destroy

      respond_to do |format|
        format.html { redirect_to staffs_path, notice: 'Error. Staff could not be created.' }
        format.json { render :index, status: :failed }
      end
    end

    UserMailer.staff_welcome_email(@user).deliver

    respond_to do |format|
      format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @staff.update!(staff_params)
    @staff.user.avatar.attach(params[:user][:avatar])
    @staff.user.update!(user_params)
    respond_to do |format|
      format.html { redirect_to @staff, notice: 'Staff was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Staff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deactivate
    @staff = Staff.find(params[:id])
    @staff.user.update(active: false)
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Staff was successfully deactivated.' }
      format.json { head :no_content }
    end
  end

  def activate
    @staff = Staff.find(params[:id])
    @staff.user.update(active: true)
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Staff was successfully reactivated.' }
      format.json { head :no_content }
    end
  end

  private
    def set_staff
      @staff = Staff.find(params[:id])
    end

    def staff_params
      params.require(:staff).permit(:initial_password, user: [ :first_name, :last_name, :gender, :phone, :email, :birth_date, :avatar ])
    end

    def user_params
      {
        first_name: params[:user][:first_name],
        last_name: params[:user][:last_name],
        phone: params[:user][:phone],
        email: params[:user][:email],
        gender: params[:user][:gender],
        password: @staff.initial_password,
        password_confirmation: @staff.initial_password,
        profile: @staff
      }
    end
end
