class RemoveLengthFromVideos < ActiveRecord::Migration[6.1]
  def change
    remove_column :videos, :length, :integer
  end
end
