class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  def index
    @search = Student.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @students = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @student
  end

  def new
    @student = Student.new
    @student.initial_password = Passgen::generate(lowercase: :only, uppercase: false)
  end

  def edit
    @student = Student.find(params[:id])
    @user = @student.user
  end

  def create
    @student = Student.new(student_params)
    if @student.family_id.nil?
      @student.family = Family.create! name: user_params[:last_name]
    end
    @student.save!

    @user = User.new(user_params)
    @user.avatar.attach(params[:user][:avatar])
    @user.save!

    respond_to do |format|
      format.html { redirect_to @student.form, notice: 'Student was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @student.update!(student_params)
    @student.user.avatar.attach(params[:user][:avatar])
    @student.user.update!(user_params)
    respond_to do |format|
      format.html { redirect_to @student, notice: 'Student was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:form_id, :family_id, :initial_password)
    end

    def user_params
      {
        first_name: params[:user][:first_name],
        last_name: params[:user][:last_name],
        phone: params[:user][:phone],
        email: params[:user][:email],
        address: params[:user][:address],
        birth_date: params[:user][:birth_date],
        gender: params[:user][:gender],
        password: @student.initial_password,
        password_confirmation: @student.initial_password,
        profile: @student
      }
    end
end
