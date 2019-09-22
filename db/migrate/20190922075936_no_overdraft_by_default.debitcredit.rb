# This migration comes from debitcredit (originally 20140130095257)
class NoOverdraftByDefault < ActiveRecord::Migration[6.0]
  def up
    change_column_default :borutus_accounts, :overdraft_enabled, false
  end

  def down
    change_column_default :borutus_accounts, :overdraft_enabled, true
  end
end
