class ChangeNumberFormatInScoreAndScoreDetails < ActiveRecord::Migration
  def change
    change_column :scores, :total, :float
    change_column :score_details, :number, :float
  end
end
