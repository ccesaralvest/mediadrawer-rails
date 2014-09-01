class AddTypeToMedia < ActiveRecord::Migration
  def change
    add_column :mediadrawer_media, :type, :string
  end
end
