class JobsController < ApplicationController

  def index
    if params[:company_id].present?
      @jobs = Job.where(company_id: params[:company_id])
    else
      @jobs = Job.where('name like ?',"%#{params[:name]}%")
      @companies = Company.where('name like ?', "%#{params[:name]}%")
    end
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

  private

  def method_name
    
  end
end
