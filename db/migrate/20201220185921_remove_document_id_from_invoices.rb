class RemoveDocumentIdFromInvoices < ActiveRecord::Migration[6.0]
  def change
    remove_column :invoices, :document_id, :string
  end
end
