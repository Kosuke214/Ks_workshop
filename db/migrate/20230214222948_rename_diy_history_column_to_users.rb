class RenameDiyHistoryColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :DIY_history, :diy_history
  end
end
