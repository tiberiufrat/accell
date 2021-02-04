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
    @observation = Observation.new
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

    # Create family for student if it doesn't exist
    if @student.family_id.nil?
      @student.family = Family.create! name: user_params[:last_name]
    end

    @student.save!

    # Try to create user for student
    begin
      @user = User.new(user_params)
      @user.avatar.attach(params[:user][:avatar]) if params[:user][:avatar]
      @user.save!
    rescue
      @student.destroy

      respond_to do |format|
        format.html { redirect_to students_path, flash: { error: 'Error. Student could not be created.' } }
        format.json { render :index, status: :failed }
      end
      return
    end

    respond_to do |format|
      format.html { redirect_to @student, notice: 'Student was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @student.update!(student_params)
    @student.user.avatar.attach(params[:user][:avatar]) if params[:user] && params[:user][:avatar]
    @student.user.update!(user_params) if params[:user]
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

  def remove_student_from_classroom
    @student = Student.find(params[:id])
    @classroom = Classroom.find(params[:classroom_id])
    if @student.form == @classroom
      @student.update! form: nil
    elsif @student.classrooms.include? @classroom
      @student.update! classrooms: @student.classrooms - [ @classroom ]
    end
    respond_to do |format|
      format.html { redirect_to @classroom, notice: 'Student was successfully removed from the classroom.' }
      format.json { head :no_content }
      format.js
    end
  end

  def transfer_student_to_form
    @student = Student.find(params[:student_id])
    @classroom = Classroom.find(params[:classroom_id])
    @student.update! form: @classroom
    respond_to do |format|
      format.html { redirect_to @classroom, notice: 'Student was successfully transferred to the classroom.' }
      format.json { head :no_content }
      format.js
    end
  end

  def add_student_to_optional_classroom
    @student = Student.find(params[:student_id])
    @classroom = Classroom.find(params[:classroom_id])
    @student.classrooms << @classroom
    respond_to do |format|
      format.html { redirect_to @classroom, notice: 'Student was successfully transferred to the classroom.' }
      format.json { head :no_content }
      format.js
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
