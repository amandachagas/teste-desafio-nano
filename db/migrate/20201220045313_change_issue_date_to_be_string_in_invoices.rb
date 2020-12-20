class ChangeIssueDateToBeStringInInvoices < ActiveRecord::Migration[6.0]
  def change
    change_column :invoices, :issue_date, :string
  end
end
