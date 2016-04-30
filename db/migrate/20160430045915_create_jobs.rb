class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :company_id
      t.string :name
      t.string :uuid
      t.date :appear_date

      t.timestamps null: false
    end
  end
end
