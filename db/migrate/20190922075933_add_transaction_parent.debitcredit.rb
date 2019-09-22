# This migration comes from debitcredit (originally 20140128131859)
class AddTransactionParent < ActiveRecord::Migration[6.0]
  def change
    add_column :borutus_transactions, :parent_transaction_id, :integer
    add_index :borutus_transactions, [:parent_transaction_id]
  end
end
