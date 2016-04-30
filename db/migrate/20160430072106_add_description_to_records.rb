class AddDescriptionToRecords < ActiveRecord::Migration
  def change
    add_column :records, :description, :text
  end
end
