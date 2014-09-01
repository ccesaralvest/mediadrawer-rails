class CreateMediadrawerMedia < ActiveRecord::Migration
  def change
    create_table :mediadrawer_media do |t|
      t.string :name
      t.string :alt
      t.string :url
      t.references :folder, index: true

      t.timestamps
    end
  end
end
