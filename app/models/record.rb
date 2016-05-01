class Record < ActiveRecord::Base
  belongs_to :job

  def paid_str
    return "無資料" unless present?

    return_str = "#{pay_low}" || '0'

    if pay_high && pay_high > 0
      return_str << " ~ #{pay_high}"
    else
      return_str << "以上"
    end

    return return_str
  end

    def need_str
    return "無資料" unless present?

    return_str = "#{need_min}" || '0'

    if need_max && need_max > 0
      return_str << " ~ #{need_max}"
    else
      return_str << "以上"
    end

    return return_str
  end
end
