class BorutusAmounts < ActiveRecord::Migration[6.0]
  def change
    create_table :borutus_amounts do |t|
      t.string :type
      t.references :account
      t.references :entry
      t.decimal :amount, :precision => 20, :scale => 10
    end
    add_index :borutus_amounts, :type
    add_index :borutus_amounts, [:account_id, :entry_id]
    add_index :borutus_amounts, [:entry_id, :account_id]
  end
end
