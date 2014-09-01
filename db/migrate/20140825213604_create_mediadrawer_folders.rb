class CreateMediadrawerFolders < ActiveRecord::Migration
  def change
    create_table :mediadrawer_folders do |t|
      t.string :name

      t.timestamps
    end
  end
end
