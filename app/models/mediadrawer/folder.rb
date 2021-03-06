module Mediadrawer
  class Folder < ActiveRecord::Base
    has_many :media_files, :class_name=> 'Media', foreign_key: 'folder_id', dependent: :destroy
    has_many :children, :class_name=>"Mediadrawer::Folder", foreign_key: "parent_id", dependent: :destroy
    belongs_to :parent, :class_name=>"Mediadrawer::Folder", foreign_key: "parent_id" 

    after_initialize :set_defaults

    scope :root, -> { find_or_create_by name: 'root_path' }

    def set_defaults
      if self.name != 'root_path'
        self.parent ||= Folder.root
      end
    end

    def name=(v)
      write_attribute :name, v.to_s.parameterize
    end

    def path
      return '' if parent.nil?
      return name if parent.path == ''
      "#{parent.path}/#{name}"
    end

    def self.discover(path=nil)
      folders = path.to_s.split '/'
      if folders.empty?
        Folder.root
      else
        folders.reduce(Folder.root) do |current_folder, folder_name|
          next current_folder if folder_name.empty?
          folder = Folder.find_by parent: current_folder, name: folder_name
          if folder
            folder
          else
            break
          end
        end
      end
    end
  end
end
