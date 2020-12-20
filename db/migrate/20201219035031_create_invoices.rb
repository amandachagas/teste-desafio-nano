class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :description
      t.string :provider
      t.string :provider_cnpj
      t.datetime :issue_date
      t.float :net_value
      t.string :document_id
      t.string :document_url
      t.references :deputy, index: true, foreign_key: true

      t.timestamps
    end
  end
end
