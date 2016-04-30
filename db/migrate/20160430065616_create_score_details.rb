class CreateScoreDetails < ActiveRecord::Migration
  def change
    create_table :score_details do |t|
      t.string :type
      t.integer :score

      t.timestamps null: false
    end
  end
end
