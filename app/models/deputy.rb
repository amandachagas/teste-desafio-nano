class Deputy < ApplicationRecord
  validates :full_name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :registered_id, presence: true

  has_many :invoices

  def sum_invoices_net_values
    return 0 unless invoices.count.positive?

    invoices.sum(:net_value).round(2).to_f
  end
end
