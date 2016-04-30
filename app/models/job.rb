class Job < ActiveRecord::Base
  belongs_to :company
  has_many :records
  has_many :scories
end
