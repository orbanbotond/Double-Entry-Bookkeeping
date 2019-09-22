require 'test_helper'

class DoubleEntryBookKeepingTest < ActiveSupport::TestCase
  test "simple_account_creation" do
    Borutus::Asset.create(:name => "Accounts Receivable")
    Borutus::Asset.create(:name => "Cash")
    Borutus::Revenue.create(:name => "Sales Revenue")
    Borutus::Liability.create(:name => "Unearned Revenue")
    Borutus::Liability.create(:name => "Sales Tax Payable")
  end

  test "recording_an_entry" do
    Borutus::Asset.create(:name => "Cash")
    Borutus::Liability.create(:name => "Unearned Revenue")

    entry = Borutus::Entry.new(
              :description => "Order placed for widgets",
              # :date => Date.yesterday,
              :debits => [
                {:account_name => "Cash", :amount => 100.00}],
              :credits => [
                {:account_name => "Unearned Revenue", :amount => 100.00}])
    entry.save
    assert_equal Borutus::Asset.balance, 100
    assert_equal Borutus::Liability.balance, 100
    assert_equal Borutus::Asset.find_by_name("Cash").balance, 100
    assert_equal Borutus::Account.trial_balance, 0
  end

  test "recording_and_entry_with_multiple_accounts" do
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
    assert Borutus::Asset.balance == 50
    assert Borutus::Revenue.balance == 45
    assert Borutus::Liability.balance == 5
  end
end
