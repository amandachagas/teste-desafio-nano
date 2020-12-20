class CreateDeputies < ActiveRecord::Migration[6.0]
  def change
    create_table :deputies do |t|
      t.string :full_name
      t.string :cpf, index: true
      t.string :political_party
      t.integer :registered_id  
      t.timestamps
    end
  end
end
