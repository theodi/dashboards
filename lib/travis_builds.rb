require 'json'
require 'open-uri'
require 'dotenv'

require 'active_support/all'
require 'action_view/helpers'

Dotenv.load

class TravisBuilds

  extend ActionView::Helpers::DateHelper

  def self.update
    jobs = get_jobs(url)
    { latest: latest(jobs), failboat: failboat(jobs) }
  end

  def self.build_images
    jobs = get_jobs(url)
    if failboat(jobs).length > 0
      {
        :image => "https://buildmemes.herokuapp.com/f?#{Time.now.to_i}",
        :state => "fail",
        :trombone => '<audio autoplay>
                        <source src="/sadtrombone.mp3" type="audio/mpeg; codecs=\'mp3\'">
                        <source src="/sadtrombone.ogg" type="audio/ogg; codecs=\'vorbis\'">
                      </audio>'
      }
    else
      {
        :image => "https://buildmemes.herokuapp.com/p?#{Time.now.to_i}",
        :state => "pass",
        :trombone => '<audio autoplay>
                        <source src="/awesome.mp3" type="audio/mpeg; codecs=\'mp3\'">
                        <source src="/awesome.ogg" type="audio/ogg; codecs=\'vorbis\'">
                      </audio>'
      }
    end
  end

  def self.latest(jobs)
    num = 12 - failboat(jobs).count
    num = 5 if num < 5
    jobs.take(num)
  end

  def self.failboat(jobs)
    jobs.select { |j| j[:status] == "failure" || j[:status] == "error" }
  end

  def self.get_jobs(url)
    json = JSON.parse(open(url).read)
    json.sort_by! { |j|
      j['last_build_finished_at'] ||
      j['last_build_started_at'] || DateTime.now.iso8601
    }.reverse!

    json.map do |job|
      time = DateTime.parse(job['last_build_finished_at'] || job['last_build_started_at']) rescue DateTime.now
      {
        job: job['slug'].split('/').last,
        date: time_ago_in_words(time) + " ago",
        status: job_status(job)
      }
    end
  end

  def self.job_status(job)
    case job['last_build_result']
    when 0
      "success"
    when 1
      "failure"
    when nil
      if job['last_build_finished_at']
        "error"
      else
        "building"
      end
    end
  end

  def self.url
    url = "https://api.travis-ci.org/repos/#{ENV['JENKINS_ORG']}.json"
  end

end
