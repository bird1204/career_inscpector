# require 'classes/man_power_bank'
require 'nokogiri'
require 'open-uri'
class ManPowerBank
  attr_accessor :name, :address, :site, :uuid, :job, :appear_date, :pay_low, :pay_high, :need_min, :need_max, :candidate

  def initialize(attributes)
    attributes.each{ |k, v| send("#{k}=", v) }
    init_candidate
  end

  def init_candidate
    html_string = Net::HTTP.get_response(URI.parse(URI.encode(candidate_url(uuid)))).body
    puts "### Search for nodes by css"
    filter = Nokogiri::HTML(html_string).css('div.sub a img')
    @candidate = 0
    if filter.present?
      @candidate = filter.to_s.match(/alt="兩週內應徵人數(.*)"/)[1].strip.split('-')[0].to_i
    end
  end

  # ManPowerBank.sync
  def self.sync
    (1..1).each do |index|
      @url = "http://www.104.com.tw/i/apis/jobsearch.cfm?kws=&area=6001001000&pgsz=2000&order=2&fmt=8&cols=J,JOB,NAME&page=#{index}"
      JSON.parse(Net::HTTP.get_response(URI.parse(URI.encode(url(index)))).body)['data'].each do |data|
        insert(
          new(
            name: data["NAME"],
            address: data["ADDRESS"],
            site: data['LINK'],
            uuid: data['J'],
            job: data['JOB'],
            appear_date: data['APPEAR_DATE'],
            pay_low: data['SAL_MONTH_LOW'],
            pay_high: data['SAL_MONTH_HIGH'],
            need_min: data['NEED_EMP'],
            need_max: data['NEED_EMP']
          )
        )
      end
    end
  end


  def self.insert object=ManPowerBank.new
    @company = Company.find_or_initialize_by(name: object.name)
    @company.name = object.name
    @company.address = object.address
    @company.site = object.site
    @company.save!

    @job = @company.jobs.find_by_uuid(object.uuid)
    if @job.blank?
      @job = @company.jobs.find_or_initialize_by(name: object.job)
    end
    @job.company_id = @company.id
    @job.uuid = object.uuid
    @job.name = object.job
    @job.appear_date = object.appear_date
    @job.save!

    @records = @job.records.build
    @records.status = "true"
    @records.pay_low = object.pay_low
    @records.pay_high = object.pay_high
    @records.need_min = object.need_min
    @records.need_max = object.need_max
    @records.record_date = Time.zone.today.to_s(:db)
    @records.candidate = object.candidate
    @records.save!
  end

  private

  def self.url index
    "http://www.104.com.tw/i/apis/jobsearch.cfm?kws=&area=6001001000&pgsz=2000&order=2&fmt=8&cols=J,JOB,NAME&page=#{index}"
  end

  def candidate_url uuid
    "http://www.104.com.tw/job/jobno=#{uuid}"
  end
end
