class CreateCompanyRates < ActiveRecord::Migration
  def change
    create_table :company_rates do |t|
      t.integer :score_id
      t.integer :score

      t.timestamps null: false
    end
  end
end
