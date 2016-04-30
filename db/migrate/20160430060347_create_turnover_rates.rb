class CreateTurnoverRates < ActiveRecord::Migration
  def change
    create_table :turnover_rates do |t|
      t.integer :score_id
      t.integer :score

      t.timestamps null: false
    end
  end
end
