class RemoveTagFromPost < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :tag, :string
  end
end
