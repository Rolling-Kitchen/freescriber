class Api::VideosController < ApplicationController
  def search
    set_video
    array_of_text = []
    @video.captions.each do |hash|
      if hash["text"].include? params[:query]
        array_of_text << hash
      end
    end
    render json: array_of_text
  end
    private
  def set_video
    @video = Video.find(params[:id])
  end
end
