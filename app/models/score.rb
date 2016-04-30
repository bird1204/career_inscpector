class Score < ActiveRecord::Base
  belongs_to :job
  has_many :score_details
  has_many :netizen_rates
  has_many :company_rates
  has_many :turnover_rates
  has_many :popular_rates

  def turnover_rate
    return nil unless turnover_rates.present?
    turnover_rates.last
  end

  def netizen_rate
    return nil unless netizen_rates.present?
    netizen_rates.last
  end

  def company_rate
    return nil unless company_rates.present?
    company_rates.last
  end

  def popular_rate
    return nil unless popular_rates.present?
    popular_rates.last
  end

end
