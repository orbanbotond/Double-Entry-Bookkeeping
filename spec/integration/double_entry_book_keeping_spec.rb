require 'rails_helper'

describe 'DoubleEntryBookKeepingTest' do
  context 'negative cases' do
    context 'the balance of the entry is not 0' do
      context 'simple entry' do
        subject(:entry) do
          Borutus::Asset.create(:name => "Cash")
          Borutus::Liability.create(:name => "Unearned Revenue")

          entry = Borutus::Entry.new(
                    :description => "Order placed for widgets",
                    # :date => Date.yesterday,
                    :debits => [
                      {:account_name => "Cash", :amount => 100.00}],
                    :credits => [
                      {:account_name => "Unearned Revenue", :amount => 99.00}])
          entry
        end

        it { should_not be_valid }

        it 'should have errors' do
          subject.valid?
          expect(subject.errors).to be_present
        end

        it 'does not change the entry number' do
          expect do
            subject.save
          end.to_not change{Borutus::Entry.count}
        end
      end

      context 'a bit complex entry' do
        subject(:entry) do
          Borutus::Asset.create(:name => "Cash")
          Borutus::Liability.create(:name => "Sales Revenue")
          Borutus::Liability.create(:name => "Sales Tax Payable")

          entry = Borutus::Entry.new(
                    :description => "Order placed for widgets",
                    :debits => [
                      {:account_name => "Cash", :amount => 50.00}],
                    :credits => [
                      {:account_name => "Sales Revenue", :amount => 45},
                      {:account_name => "Sales Tax Payable", :amount => 4}])
          entry
        end

        it { should_not be_valid }

        it 'should have errors' do
          subject.valid?
          expect(subject.errors).to be_present
        end

        it 'does not change the entry number' do
          expect do
            subject.save
          end.to_not change{Borutus::Entry.count}
        end
      end
    end
  end

  context 'positive cases' do
    context "simple_account_creation" do
      it 'creates accounts' do
        expect do
          expect do
            Borutus::Asset.create(:name => "Accounts Receivable")
            Borutus::Asset.create(:name => "Cash")
          end.to change{Borutus::Asset.count}.from(0).to(2)
          expect do
            Borutus::Revenue.create(:name => "Sales Revenue")
          end.to change{Borutus::Revenue.count}.from(0).to(1)
          expect do
            Borutus::Liability.create(:name => "Unearned Revenue")
            Borutus::Liability.create(:name => "Sales Tax Payable")
          end.to change{Borutus::Liability.count}.from(0).to(2)
        end.to change{Borutus::Account.count}.from(0).to(5)
      end
    end

    context "recording an entry with only onepair of debit credits" do
      subject(:entry) do
        Borutus::Asset.create(:name => "Cash")
        Borutus::Liability.create(:name => "Unearned Revenue")

        entry = Borutus::Entry.new(
                  :description => "Order placed for widgets",
                  # :date => Date.yesterday,
                  :debits => [
                    {:account_name => "Cash", :amount => 100.00}],
                  :credits => [
                    {:account_name => "Unearned Revenue", :amount => 100.00}])
        entry
      end

      before do
        subject.save
      end

      it { should be_truthy }

      it 'produces an Entry count of 1' do
        expect(Borutus::Entry.count).to eq(1)
      end

      it 'produces an Amount count of 2' do
        expect(Borutus::Amount.count).to eq(2)
      end

      it 'produces a CreditAmount count of 1' do
        expect(Borutus::CreditAmount.count).to eq(1)
      end

      it 'produces a DebitAmount count of 1' do
        expect(Borutus::DebitAmount.count).to eq(1)
      end

      it 'produces an Asset balance of 100' do
        expect(Borutus::Asset.balance).to eq(100)
      end

      it 'produces a Liability balance of 100' do
        expect(Borutus::Liability.balance).to eq(100)
      end

      it 'produces a Cash Asset balance of 100' do
        expect(Borutus::Asset.find_by_name("Cash").balance).to eq(100)
      end

      it 'produces an Unearned Revenue Liability balance of 100' do
        expect(Borutus::Liability.find_by_name("Unearned Revenue").balance).to eq(100)
      end

      it 'produces a trial balance of 0' do
        expect(Borutus::Account.trial_balance).to eq(0)
      end

      it 'leaves the expences intact' do
        expect(Borutus::Expense.balance).to eq(0)
      end

      it 'leaves the revenue intact' do
        expect(Borutus::Revenue.balance).to eq(0)
      end
    end

    context "recording a bit more compex entry" do
      subject do
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
        entry
      end

      before do
        subject.save
      end

      it { should be_truthy }

      it 'produces an Entry count of 1' do
        expect(Borutus::Entry.count).to eq(1)
      end

      it 'produces an Amount count of 3' do
        expect(Borutus::Amount.count).to eq(3)
      end

      it 'produces a CreditAmount count of 2' do
        expect(Borutus::CreditAmount.count).to eq(2)
      end

      it 'produces a DebitAmount count of 1' do
        expect(Borutus::DebitAmount.count).to eq(1)
      end

      it 'produces a trial balance of 0' do
        expect(Borutus::Account.trial_balance).to eq(0)
      end

      it 'produces a Liability balance of 5' do
        expect(Borutus::Liability.balance).to eq(5)
      end

      it 'produces an Asset balance of 50' do
        expect(Borutus::Asset.balance).to eq(50)
      end

      it 'produces a Revenue balance of 45' do
        expect(Borutus::Revenue.balance).to eq(45)
      end
    end
  end
end
