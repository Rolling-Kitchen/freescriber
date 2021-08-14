class AddCaptionToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :captions, :jsonb
    drop_table :subtitles
  end
end
