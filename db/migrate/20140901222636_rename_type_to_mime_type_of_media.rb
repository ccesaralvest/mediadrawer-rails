class RenameTypeToMimeTypeOfMedia < ActiveRecord::Migration
  def change
    rename_column 'mediadrawer_media', 'type', 'mime_type'
  end
end
