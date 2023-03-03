class RenameTagNameColumnToPostTags < ActiveRecord::Migration[6.1]
  def change
    rename_column :post_tags, :tag_name, :name
  end
end
