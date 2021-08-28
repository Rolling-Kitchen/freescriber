class AddDurationToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :duration, :integer
  end
end
