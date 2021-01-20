class ParentsController < ApplicationController
  before_action :set_parent, only: %i[ show edit update destroy ]

  def index
    @search = Parent.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @parents = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @parent
  end

  def new
    @parent = Parent.new
    @parent.initial_password = Passgen::generate(lowercase: :only, uppercase: false)
  end

  def edit
    @parent = Parent.find(params[:id])
    @user = @parent.user
  end

  def create
    @parent = Parent.new(parent_params)
    @parent.save!

    if @parent.family.main_parent.nil?
      @parent.family.update!(main_parent: @parent)
    end

    @user = User.new(user_params)
    @user.avatar.attach(params[:user][:avatar])
    @user.save!

    UserMailer.parent_welcome_email(@user).deliver

    respond_to do |format|
      format.html { redirect_to @parent.family, notice: 'Parent was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @parent.update!(parent_params)
    @parent.user.avatar.attach(params[:user][:avatar])
    @parent.user.update!(user_params)
    respond_to do |format|
      format.html { redirect_to @parent.family, notice: 'Parent was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @parent.destroy
    respond_to do |format|
      format.html { redirect_to parents_url, notice: 'Parent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_parent
      @parent = Parent.find(params[:id])
    end

    def parent_params
      params.require(:parent).permit(:initial_password, :quality, :family_id)
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
        password: @parent.initial_password,
        password_confirmation: @parent.initial_password,
        profile: @parent
      }
    end
end
