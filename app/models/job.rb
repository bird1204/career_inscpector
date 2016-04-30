class Job < ActiveRecord::Base
  acts_as_votable
  belongs_to :company
  has_many :records
  has_many :scores

  def score
    return nil unless scores.present?
    scores.last.try(:total)
  end

  def record
    return nil unless records.present?
    records.last
  end

  def paid_str
    return "無資料" unless records.present?

    return_str = "#{records.last.try(:pay_low)}" || '0'
    
    if records.last.try(:pay_high) > 0
      return_str << " ~ #{records.last.try(:pay_high)}" 
    else
      return_str << "以上" 
    end
    
    return return_str
  end
end
