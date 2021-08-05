class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :video_source

      t.timestamps
    end
  end
end
