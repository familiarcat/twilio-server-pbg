class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :to
      t.string :from
      t.string :text
      t.string :audio_url
      t.string :image_url
      t.string :media_url

      t.timestamps
    end
  end
end
