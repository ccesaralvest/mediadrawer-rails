module Mediadrawer
  class Folder < ActiveRecord::Base
    has_many :files,    :class_name=> 'Media', foreign_key: 'folder_id'
    has_many :children, :class_name=>"Mediadrawer::Folder", foreign_key: "parent_id"
    belongs_to :parent, :class_name=>"Mediadrawer::Folder", foreign_key: "parent_id"

    after_initialize :set_defaults

    def set_defaults
      if name != 'root_path'
        self.parent ||= Folder.root
      end
    end

    def self.root
      find_or_create_by name: 'root_path'
    end
  end
end
