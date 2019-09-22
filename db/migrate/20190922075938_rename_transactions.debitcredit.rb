# This migration comes from debitcredit (originally 20150106165647)
class RenameTransactions < ActiveRecord::Migration[6.0]
  def change
    rename_table :debitcredit_transactions, :debitcredit_entries
    rename_column :debitcredit_entries, :parent_transaction_id, :parent_entry_id
    rename_column :debitcredit_entries, :inverse_transaction_id, :inverse_entry_id

    rename_column :debitcredit_items, :transaction_id, :entry_id
  end
end
