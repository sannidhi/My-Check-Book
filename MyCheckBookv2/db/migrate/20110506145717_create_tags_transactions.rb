class CreateTagsTransactions < ActiveRecord::Migration
  def self.up
    create_table :tags_transactions, :id => false do |t|
      t.references :tag, :null => false
      t.references :transaction, :null => false
    end
    
    add_index :tags_transactions, [:tag_id, :transaction_id], :unique => true, :name => 'index_tags_transactions'
  end

  def self.down
    remove_index :tags_transactions, :index_tags_transactions
    drop_table :tags_transactions
  end
end
