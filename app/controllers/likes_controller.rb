class LikesController < ApplicationController
  before_action :find_likeable
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like this more than once"
    else
      @likeable.likes.create(user_id: current_user.id)
    end
    
    respond_to do |format|
      format.html { redirect_to @likeable }
      format.js
    end
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end

    respond_to do |format|
      format.html { redirect_to @likeable }
      format.js
    end
  end

  private

  def find_likeable
    @likeable = GlobalID::Locator.locate(params[:likeable_gid])
  end

  def already_liked?
    Like.where(user_id: current_user.id, likeable: GlobalID::Locator.locate(params[:likeable_gid])).exists?
  end

  def find_like
    @like = Like.find(params[:id])
  end 
end
