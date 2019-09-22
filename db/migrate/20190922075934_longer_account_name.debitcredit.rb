# This migration comes from debitcredit (originally 20140128134203)
class LongerAccountName < ActiveRecord::Migration[6.0]
  def up
    change_column :borutus_accounts, :name, :string, limit: 32, null: false
  end

  def down
    change_column :borutus_accounts, :name, :string, limit: 16, null: false
  end
end
