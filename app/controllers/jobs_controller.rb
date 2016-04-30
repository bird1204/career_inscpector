class JobsController < ApplicationController

  def index
    #@url = JSON.parse(Net::HTTP.get_response(URI.parse(URI.encode(url))).body)
  end

  def search
    if params[:search].present?
    else
    end
  end


  private
  def url
    "http://www.104.com.tw/i/apis/jobsearch.cfm?cat=2001001001&area=6001001001&fmt=8&cols=J,JOB,NAME"
  end
end
