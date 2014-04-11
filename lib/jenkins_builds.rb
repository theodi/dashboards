require 'json'
require 'net/http'

class JenkinsBuilds
  
  def self.update
    { latest: latest, failboat: failboat }
  end
  
  def self.build_images
    json = JSON.parse(Net::HTTP.get URI.parse("http://jenkins.theodi.org/view/failboat/api/json"))
    if json['jobs'].length > 0
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
  
  def self.latest
    url = "http://jenkins.theodi.org/view/All/api/json?tree=jobs[name,lastBuild[result,timestamp]]"
    get_jobs(url, 5)
  end
  
  def self.failboat
    url = "http://jenkins.theodi.org/view/failboat/api/json?tree=jobs[name,lastBuild[result,timestamp]]"
    get_jobs(url)
  end
  
  def self.get_jobs(url, limit = 100)
    json = JSON.parse(Net::HTTP.get URI.parse(url))
    json['jobs'].map do |k,v| 
      if k['lastBuild'].nil?
        k['lastBuild'] = {}
        k['lastBuild']['timestamp'] = 0
      end
    end
    
    json['jobs'].sort_by! { |j| j['lastBuild']['timestamp']  }.reverse!
    
    jobs = json['jobs'].take(limit).map do |job|
      if job['lastBuild']['timestamp'] != 0
        date = DateTime.strptime((job['lastBuild']['timestamp'] / 1000).to_s, '%s').strftime('%Y-%m-%d %H:%M:%S')
        { job: job['name'], date: date, status: job['lastBuild']['result'].downcase }
      end
    end
    
    jobs.compact
  end
  
end