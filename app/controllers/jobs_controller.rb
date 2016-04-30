class JobsController < ApplicationController

  def index
    #@url = JSON.parse(Net::HTTP.get_response(URI.parse(URI.encode(url))).body)
  end

  def search
    if params[:search].present?
      @url = "http://www.104.com.tw/i/apis/jobsearch.cfm?kws=#{params[:search]}&page=1&pgsz=2000&area=6001001000&order=2&fmt=8&cols=J,JOB,NAME,APPEAR_DATE,NEED_EMP,NEED_EMP1"
    else
      @url = "ㄏ"
    end
    @result = JSON.parse(Net::HTTP.get_response(URI.parse(URI.encode(@url))).body)
    @recordcount = @result['RECORDCOUNT']
    @pagecount = @result['PAGECOUNT']
    @page = @result['PAGE']
    @totalpage = @result['TOTALPAGE']
    @datas = @result['data']
  end


  private
  def url
    "http://www.104.com.tw/i/apis/jobsearch.cfm?kws=Internet%E7%A8%8B%E5%BC%8F%E8%A8%AD%E8%A8%88%E5%B8%AB&area=6001001000&order=2&fmt=8&cols=J,JOB,NAME"
  end
end
