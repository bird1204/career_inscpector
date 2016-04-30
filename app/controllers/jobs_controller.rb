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

  #算每筆工作的流動率權重
  def score
    #單次拉1000筆jobs作處理
    @jobs = Job.find_each(:limit => 1000)
    # 設定一個週期為三十天
    @days = (30.days.ago.to_date..Date.today).map{ |date| date.strftime("%Y-%m-%d") }

    #雙層迴圈就像雙層牛肉吉士堡一樣美味
    @jobs.each do |job|
      @days.each do |day|
        record = Record.find(job_id: job.id, status: true, record_date: day)
        if record.status?
          @exist_day = @exist_day + 1
        end
      end
    end

    @exist_day = 0
    @score = @exist_day / 30
  end

  #找出所有職缺分數的中位數
  def median
    @records = Record.find_each(:limit => 1000).map{ |r| r.total}
    array =  @records.sort!
    elements = array.count
    center =  elements / 2
    elements.even? ? (array[center] + array[center+1])/2 : array[center]
  end

  private

  def method_name

  end
end
