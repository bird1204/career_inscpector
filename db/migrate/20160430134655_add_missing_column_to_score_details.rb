class AddMissingColumnToScoreDetails < ActiveRecord::Migration
  def change
    add_column :score_details, :score_id, :integer
  end
end
