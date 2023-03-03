class DropTableTags < ActiveRecord::Migration[6.1]
  def change
    drop_table :tags do # rubocop:todo Lint/EmptyBlock
    end
  end
end
