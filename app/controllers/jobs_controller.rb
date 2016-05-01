class JobsController < ApplicationController
  def index
    if params[:company_id].present?
      @jobs = Job.where(company_id: params[:company_id])
    else
      @jobs = Job.where('name like ?',"%#{params[:name]}%")
      @companies = Company.where('name like ?', "%#{params[:name]}%")
    end
  end

  def show
    @job = Job.find(params[:id])
    @recommend_jobs = Job.where('name like ? AND id != ?', "%#{@job.name[0..3]}%", @job.id)
  end

  def score
    @days = (1.days.ago.to_date..Date.today).map{ |date| date.strftime("%Y-%m-%d") }
    @exist_day = 0
    Job.find_each(:batch_size => 1000) do |jobs|

      @days.each do |day|
        @record = Record.find_by(job_id: jobs.id, record_date: '2016-04-30')

        if !@record.status.blank?
          @exist_day = @exist_day + 1
        end
      end
      @total_day = 30.0
      @number = (@exist_day / @total_day) * 100

      score = jobs.scores.build(total: 0)
      score.save!
      score.turnover_rates.build(number: @number).save!
      @exist_day = 0
    end
  end

  #找出所有職缺分數的中位數
  def median
    array = []
    TurnoverRate.find_each(:batch_size => 1000) do |rate|
      array << rate.number
    end
    array = array.sort!
    elements = array.count
    center =  elements / 2
    result = elements.even? ? (array[center] + array[center+1])/2 : array[center]
  end

  def upvote
    @job = Job.find(params[:id])
    @job.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @job = Job.find(params[:id])
    @job.downvote_by current_user
    redirect_to :back
  end
end
