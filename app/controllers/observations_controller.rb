class ObservationsController < ApplicationController
  before_action :set_observation, only: %i[ show edit update destroy ]

  def index
    @search = Observation.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @observations = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @observation
  end

  def new
    @observation = Observation.new
  end

  def edit
  end

  def create
    @observation = Observation.new(observation_params)
    @observation.save!

    respond_to do |format|
      format.html { redirect_to @observation, notice: 'Observation was successfully created.' }
      format.json { render :show, status: :created }
      format.js
    end
  end

  def update
    @observation.update!(observation_params)
    respond_to do |format|
      format.html { redirect_to @observation, notice: 'Observation was successfully updated.' }
      format.json { render :show }
      format.js
    end
  end

  def destroy
    @observation.destroy
    respond_to do |format|
      format.html { redirect_to observations_url, notice: 'Observation was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def set_observation
      @observation = Observation.find(params[:id])
    end

    def observation_params
      params.require(:observation).permit(:text, :creator_id, :observationable_id, :observationable_type)
    end
end
