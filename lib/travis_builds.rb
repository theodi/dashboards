require 'json'
require 'open-uri'
require 'dotenv'

Dotenv.load

class TravisBuilds
  
  def self.update
    jobs = get_jobs(url)
    { latest: latest(jobs), failboat: failboat(jobs) }
  end
  
  def self.build_images
    jobs = get_jobs(url)
    if failboat(jobs).length > 0
      {
        :image => "https://buildmemes.herokuapp.com/f",
        :state => "fail",
        :trombone => '<audio autoplay> 
                        <source src="/sadtrombone.mp3" type="audio/mpeg; codecs=\'mp3\'">
                        <source src="/sadtrombone.ogg" type="audio/ogg; codecs=\'vorbis\'">
                      </audio>'
      }
    else
      {
        :image => "https://buildmemes.herokuapp.com/p",
        :state => "pass",
        :trombone => '<audio autoplay> 
                        <source src="/awesome.mp3" type="audio/mpeg; codecs=\'mp3\'">
                        <source src="/awesome.ogg" type="audio/ogg; codecs=\'vorbis\'">
                      </audio>'
      }
    end
  end
  
  def self.latest(jobs)
    jobs.take(5)
  end
  
  def self.failboat(jobs)
    jobs.select { |j| j[:status] == "failure" }
  end
  
  def self.get_jobs(url)
    json = JSON.parse(open(url).read)
    json.sort_by!{ |j| j['last_build_started_at'] }.reverse!
    
    json.map do |job|
      { job: job['slug'], date: job['last_build_started_at'], status: job_status(job['last_build_result']) }
    end
  end
  
  def self.job_status(result)
    case result
    when 0
      "success"
    when 1
      "failure"
    when nil
      "disabled"
    end
  end
  
  def self.url
    url = "https://api.travis-ci.org/repos/#{ENV['JENKINS_ORG']}.json"
  end
  
end