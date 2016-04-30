class CreateNetizenRates < ActiveRecord::Migration
  def change
    create_table :netizen_rates do |t|
      t.integer :score_id
      t.integer :score

      t.timestamps null: false
    end
  end
end
