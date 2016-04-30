class RenameScoreFromScoreDetails < ActiveRecord::Migration
  def change
    rename_column :score_details, :score, :number
  end
end
