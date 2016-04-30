class Score < ActiveRecord::Base
  belongs_to :job
  has_many :score_details

  def score_detail
    return nil unless score_details.present?
    score_details.last
  end
end
