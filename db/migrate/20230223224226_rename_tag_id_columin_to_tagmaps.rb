class RenameTagIdColuminToTagmaps < ActiveRecord::Migration[6.1]
  def change
    rename_column :tagmaps, :tag_id, :post_tag_id
  end
end
