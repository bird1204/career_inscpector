class Company < ActiveRecord::Base
  has_many :jobs

  def sync
    (1..7).each do |index|
      #@url = "http://www.104.com.tw/i/apis/jobsearch.cfm?kws=#{params[:search]}&page=1&pgsz=2000&area=6001001000&order=2&fmt=8&cols=J,JOB,ADDRESS,LINK,APPEAR_DATE,NAME,NEED_EMP,NEED_EMP1,SAL_MONTH_LOW,SAL_MONTH_HIGH"
      @url = "http://www.104.com.tw/i/apis/jobsearch.cfm?kws=&area=6001001000&pgsz=2000&order=2&fmt=8&cols=J,JOB,NAME&page=#{index}"
      @result = JSON.parse(Net::HTTP.get_response(URI.parse(URI.encode(@url))).body)
      @result['data'].each do |data|
        sync_method data
      end
    end
  end

  def sync_method data
    @company = Company.find_or_initialize_by(name: data['NAME'])
    @company.name = data['NAME']
    @company.address = data['ADDRESS']
    @company.site = data['LINK']
    @company.save!

    @job = @company.jobs.find_by_uuid(data['J'])
    if @job.blank?
      @job = @company.jobs.find_or_initialize_by(name: data['JOB'])
    end
    @job.company_id = @company.id
    @job.uuid = data['J']
    @job.name = data['JOB']
    @job.appear_date = data['APPEAR_DATE']
    @job.save!

    @records = @job.records.build
    @records.status = "true"
    @records.pay_low = data['SAL_MONTH_LOW']
    @records.pay_high = data['SAL_MONTH_HIGH']
    @records.need_min = data['NEED_EMP']
    @records.need_max = data['NEED_EMP1']
    @records.record_date = (Date.today)
    @records.save!
  end
end
