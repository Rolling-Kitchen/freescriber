class AddStartToSubtitles < ActiveRecord::Migration[6.1]
  def change
    add_column :subtitles, :start, :string
    add_column :subtitles, :end, :string
    remove_column :subtitles, :timestamp, :string
  end
end
