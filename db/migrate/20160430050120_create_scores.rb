class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :job_id
      t.integer :total

      t.timestamps null: false
    end
  end
end
