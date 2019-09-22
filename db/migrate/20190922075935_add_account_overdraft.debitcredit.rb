# This migration comes from debitcredit (originally 20140128153104)
class AddAccountOverdraft < ActiveRecord::Migration[6.0]
  def change
    add_column :debitcredit_accounts, :overdraft_enabled, :boolean, null: false, default: true
  end
end
