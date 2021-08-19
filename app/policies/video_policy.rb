class VideoPolicy < ApplicationPolicy
  attr_reader :user, :video

  def initialize(user, video)
    @user = user
    @video = video
  end
  
  class Scope < Scope
    def resolve
      user.videos
    end
  end
  
  def show?
    video.user === @user
  end
end
