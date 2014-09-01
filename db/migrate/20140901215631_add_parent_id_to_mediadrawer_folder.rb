class AddParentIdToMediadrawerFolder < ActiveRecord::Migration
  def change
    add_column :mediadrawer_folders, :parent_id, :integer
  end
end
