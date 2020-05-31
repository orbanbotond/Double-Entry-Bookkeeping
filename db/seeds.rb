# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Borutus::Asset.create(:name => "Real Estate")
Borutus::Asset.create(:name => "Office")
Borutus::Asset.create(:name => "Transport Vehicles")
Borutus::Asset.create(:name => "Equity Capital")
Borutus::Asset.create(:name => "Working Capital")
Borutus::Asset.create(:name => "Accounts Receivable")

Borutus::Liability.create(:name => "Investment")
Borutus::Liability.create(:name => "Sales Tax Payable")

Borutus::Revenue.create(:name => "Sales Revenue")

entry = Borutus::Entry.new(
    :description => "Bootstrap Capital Injection",
    :debits => [{:account_name => "Equity Capital", :amount => 1000.00},
                {:account_name => "Working Capital", :amount => 9000.00}],
    :credits => [{:account_name => "Investment", :amount => 10000.00}])
entry.save

entry = Borutus::Entry.new(
    :description => "Transportation Vehicle Procurement",
    :debits => [{:account_name => "Transport Vehicles", :amount => 3400.00}],
    :credits => [{:account_name => "Working Capital", :amount => 3400.00}])
entry.save
