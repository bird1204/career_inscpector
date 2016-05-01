class JobRate
  attr_reader :netizen_rate, :popular_rate, :company_rate, :turnover_rate, :total, :median
  attr_writer :job

  def initialize(job=Job.new)
    @netizen_rate = 0
    @popular_rate = 0
    @company_rate = 0
    @turnover_rate = 0
    @job = job
    @total = 0
    @median = TurnoverRate.median
  end

  def calculate
    score = @job.scores.build(total: 0)
    score.save!
    score.turnover_rates.build(number: cal_turnover_rate).save!
    score.popular_rates.build(number: cal_popular_rate).save!
    score.company_rates.build(number: cal_company_rate).save!
    score.netizen_rates.build(number: cal_netizen_rate).save!
    total = (cal_netizen_rate * 0.1 + cal_company_rate * 0.2 + cal_popular_rate * 0.2 + cal_turnover_rate * 0.5)
    score.total = if total >= 100
      total / (100 / total)
    else
      total * (100 / total)
    end
    score.save!
  end

  private

  def cal_turnover_rate
    exist_day = 0
    (1.days.ago.to_date..Date.today).map{ |date| date.strftime("%Y-%m-%d") }.each do |day|
      exist_day += 1 unless Record.find_by(job_id: @job.id, record_date: '2016-04-30').status.blank?
    end
    rate = ((exist_day / 30.0) * 100) - @median
    return 0 if rate >= 25
    return 10 if rate >= 20
    return 20 if rate >= 15
    return 30 if rate >= 10
    return 40 if rate >= 5
    return 50 if rate >= 0
    return 60 if rate <= -5
    return 70 if rate <= -10
    return 80 if rate <= -15
    return 90 if rate <= -20
    return 100 if rate <= -25
  end

  def cal_popular_rate
    return (@job.record.candidate.to_f / Record.where(record_date: Time.zone.today.to_s(:db)).avg(:candidate).to_f) * 100
  end

  def cal_netizen_rate
    return (@job.get_upvotes.size.to_f / @job.votes_for.size.to_f) * 100
  end

  def cal_company_rate
    return BadBoss.new(@job.name).rate
  end
end
