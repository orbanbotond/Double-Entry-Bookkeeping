# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Borutus::Asset.create(:name => "Real Estate")
Borutus::Asset.create(:name => "Office")
Borutus::Asset.create(:name => "Transport")
Borutus::Equity.create(:name => "Equity Capital")
Borutus::Equity.create(:name => "Working Capital")
Borutus::Revenue.create(:name => "Investment")
Borutus::Liability.create(:name => "Earned Premium")
Borutus::Asset.create(:name => "Accounts Receivable")
Borutus::Revenue.create(:name => "Sales Revenue")
Borutus::Liability.create(:name => "Sales Tax Payable")

entry = Borutus::Entry.new(
    :description => "Bootstrap Injection",
    :debits => [{:account_name => "Earned Premium", :amount => 10000.00}],
    :credits => [{:account_name => "Investment", :amount => 10000.00}])
entry.save
