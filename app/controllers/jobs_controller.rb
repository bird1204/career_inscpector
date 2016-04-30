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

  def search
    if params[:search].present?
      @url = "http://www.104.com.tw/i/apis/jobsearch.cfm?kws=#{params[:search]}&page=1&pgsz=2000&area=6001001000&order=2&fmt=8&cols=J,JOB,NAME,APPEAR_DATE,NEED_EMP,NEED_EMP1,ADDRESS"
    else
      @url = "ㄏ"
    end
    @result = JSON.parse(Net::HTTP.get_response(URI.parse(URI.encode(@url))).body)
    @recordcount = @result['RECORDCOUNT']
    @pagecount = @result['PAGECOUNT']
    @page = @result['PAGE']
    @totalpage = @result['TOTALPAGE']
    @datas = @result['data']
    @datas.each do |data|
    end
  end

  def score
    @days = (1.days.ago.to_date..Date.today).map{ |date| date.strftime("%Y-%m-%d") }

    Job.find_each(:batch_size => 1000) do |jobs|
      @exist_day = 0
      @days.each do |day|
        @record = Record.find_by(job_id: jobs.id, record_date: '2016-04-30')

        if @record.status = 1
          @exist_day = @exist_day + 1
        end
      end
      @number = @exist_day / 30
      @number = @number * 100
      score = jobs.scores.build(total: 0)
      score.save!
      score.turnover_rates.build(number: @exist_day).save!
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

  private

  def method_name

  end
end
