class Score < ActiveRecord::Base
  belongs_to :job
  has_many :score_details
end
