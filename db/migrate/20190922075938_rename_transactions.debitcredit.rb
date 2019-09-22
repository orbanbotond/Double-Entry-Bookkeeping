# This migration comes from debitcredit (originally 20150106165647)
class RenameTransactions < ActiveRecord::Migration[6.0]
  def change
    rename_table :borutus_transactions, :borutus_entries
    rename_column :borutus_entries, :parent_transaction_id, :parent_entry_id
    rename_column :borutus_entries, :inverse_transaction_id, :inverse_entry_id

    rename_column :borutus_items, :transaction_id, :entry_id
  end
end
