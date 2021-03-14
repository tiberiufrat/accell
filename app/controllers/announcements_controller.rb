class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: %i[ show edit update destroy ]

  def index
    @search = Announcement.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @announcements = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @announcement
  end

  def new
    @announcement = Announcement.new
  end

  def edit
  end

  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.save!

    respond_to do |format|
      format.html { redirect_to @announcement, notice: 'Announcement was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @announcement.update!(announcement_params)
    respond_to do |format|
      if params[:announcement][:deleted] == 'true'
        format.html { redirect_to announcements_path, notice: 'Announcement was successfully deleted.' }
      elsif params[:announcement][:restore] == 'true'
        format.html { redirect_to announcements_path, notice: 'Announcement was successfully restored.' }
      else
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
      end
      format.json { render :show }
    end
  end

  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Announcement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    def announcement_params
      params.require(:announcement).permit(:title, :text, :category, :sender_id, :scheduled_for, :deleted, user_ids: [])
    end
end
