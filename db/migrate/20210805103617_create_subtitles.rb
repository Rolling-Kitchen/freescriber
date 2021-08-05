class CreateSubtitles < ActiveRecord::Migration[6.1]
  def change
    create_table :subtitles do |t|
      t.references :video, null: false, foreign_key: true
      t.text :text
      t.string :timestamp

      t.timestamps
    end
  end
end
