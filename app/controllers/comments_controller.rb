class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  def index
    @search = Comment.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @comments = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @comment
  end

  def new
    @announcement = Announcement.find(params[:announcement_id])
    @comment = @announcement.comments.new(parent_id: params[:parent_id])
  end

  def edit
  end

  def create
    @announcement = Announcement.find(params[:announcement_id])
    @comment = @announcement.comments.new(comment_params)
    @comment.user = current_user
    @comment.save!

    respond_to do |format|
      format.html { redirect_to @announcement, notice: 'Comment was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @comment.update!(comment_params)
    respond_to do |format|
      format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :announcement_id, :parent_id, :user_id)
    end
end
