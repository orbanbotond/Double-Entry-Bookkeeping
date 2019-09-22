# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Borutus::Asset.create(:name => "Accounts Receivable")
Borutus::Revenue.create(:name => "Sales Revenue")
Borutus::Liability.create(:name => "Sales Tax Payable")
entry = Borutus::Entry.build(
          :description => "Sold some widgets",
          :debits => [
            {:account_name => "Accounts Receivable", :amount => 50}],
          :credits => [
            {:account_name => "Sales Revenue", :amount => 45},
            {:account_name => "Sales Tax Payable", :amount => 5}])
entry.save

