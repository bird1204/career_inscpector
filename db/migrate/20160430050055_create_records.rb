class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :job_id
      t.boolean :status
      t.integer :pay_low
      t.integer :pay_high
      t.integer :need_min
      t.integer :need_max
      t.integer :candidate
      t.date :record_date

      t.timestamps null: false
    end
  end
end
