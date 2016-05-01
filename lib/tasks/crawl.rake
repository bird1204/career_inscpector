namespace :crawl do
  task :sync_man_power_bank => :environment do
    p "[INIT]-----------sync_man_power_bank"
    p Time.zone.now
    ManPowerBank.sync
    p "[DONE]-----------sync_man_power_bank"
  end

  task :update_job_score => :environment do
    p "[INIT]-----------update_job_score"
    p Time.zone.now
    ManPowerBank.sync
    p "[DONE]-----------update_job_score"
  end
end