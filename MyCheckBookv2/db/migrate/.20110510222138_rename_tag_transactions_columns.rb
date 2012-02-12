class RenameTagTransactionsColumns < ActiveRecord::Migration
  def self.up
    rename_column :tags_transactions, :tags_id, :tag_id
    rename_column :tags_transactions, :transactions_id, :transaction_id
  end

  def self.down
    rename_column :tags_transactions, :tag_id, :tags_id
    rename_column :tags_transactions, :transaction_id, :transactions_id
  end
end
