class Score < ActiveRecord::Base
  belongs_to :job
  has_many :popular_rates
  has_many :company_rates
  has_many :netizen_rates
  has_many :turnover_rates
end
