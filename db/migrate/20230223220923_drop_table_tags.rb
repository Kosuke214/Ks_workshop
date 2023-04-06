class DropTableTags < ActiveRecord::Migration[6.1]
  def up
    drop_table :tags
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
