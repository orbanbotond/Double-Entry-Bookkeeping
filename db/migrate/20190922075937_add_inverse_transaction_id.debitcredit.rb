# This migration comes from debitcredit (originally 20140612113944)
class AddInverseTransactionId < ActiveRecord::Migration[6.0]
  def change
    add_column :debitcredit_transactions, :inverse_transaction_id, :integer
  end
end
