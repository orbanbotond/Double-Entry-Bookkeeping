# This migration comes from debitcredit (originally 20140121181304)
class CreateDebitcreditTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :borutus_transactions do |t|
      t.integer :reference_id,   null: true
      t.string  :reference_type, null: true, limit: 32
      t.string  :kind,           null: true
      t.string  :description,    null: false
      t.datetime :date,          null: false
      t.timestamps
    end
    add_index :borutus_transactions, [:reference_id, :reference_type, :id], name: :rindex
  end
end
