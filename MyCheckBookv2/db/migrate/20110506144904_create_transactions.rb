class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :user_id
      t.date :transaction_date
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
