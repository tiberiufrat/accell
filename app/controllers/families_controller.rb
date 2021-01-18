class FamiliesController < ApplicationController
  before_action :set_family, only: %i[ show edit update destroy ]

  def index
    @search = Family.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @families = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @family
  end

  def new
    @family = Family.new
  end

  def edit
  end

  def create
    @family = Family.new(family_params)
    @family.save!

    respond_to do |format|
      format.html { redirect_to @family, notice: 'Family was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @family.update!(family_params)
    respond_to do |format|
      format.html { redirect_to @family, notice: 'Family was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @family.destroy
    respond_to do |format|
      format.html { redirect_to families_url, notice: 'Family was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:name)
    end
end
