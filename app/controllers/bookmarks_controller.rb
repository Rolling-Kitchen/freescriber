class BookmarksController < ApplicationController
  before_action :set_video, only: :create

  def create
    @bookmark = @video.bookmarks.find_or_initialize_by(bookmark_params)
    @bookmark.save
    redirect_to video_path(@video)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  private

  def set_video
    @video = Video.find(params[:video_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:list_id)
  end
end
