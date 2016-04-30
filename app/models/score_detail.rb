class ScoreDetail < ActiveRecord::Base
  belongs_to :score
  validates_presence_of :score
end
