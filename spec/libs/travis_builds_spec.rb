require 'spec_helper'
require 'travis_builds'

require 'dotenv'
Dotenv.load

describe TravisBuilds do

  before :all do
    Timecop.freeze(2014,02,22)
  end

  describe "with passing builds" do

    before :all do
      @json = [
        {
          "id"                     => 877145,
          "slug"                   => "theodi/dashboards",
          "description"            => "ODI dashboards, built using Dashing",
          "last_build_id"          => 19330461,
          "last_build_number"      => "103",
          "last_build_status"      => 0,
          "last_build_result"      => 0,
          "last_build_duration"    => 431,
          "last_build_language"    => nil,
          "last_build_started_at"  => "2014-02-21T12:43:51Z",
          "last_build_finished_at" => "2014-02-21T12:50:44Z"
        },
        {
          "id"                     => 1544293,
          "slug"                   => "theodi/breasal",
          "description"            => "A Ruby gem that converts GB and Irish Eastings and Northing to Latitude and Longitude",
          "last_build_id"          => 19329423,
          "last_build_number"      => "3",
          "last_build_status"      => 0,
          "last_build_result"      => 0,
          "last_build_duration"    => 121,
          "last_build_language"    => nil,
          "last_build_started_at"  => "2014-02-21T12:17:53Z",
          "last_build_finished_at" => "2014-02-21T12:18:44Z"
        },
        {
          "id"                     => 1732224,
          "slug"                   => "theodi/csvlint",
          "description"            => "",
          "last_build_id"          => 19324022,
          "last_build_number"      => "246",
          "last_build_status"      => nil,
          "last_build_result"      => nil,
          "last_build_duration"    => 523,
          "last_build_language"    => nil,
          "last_build_started_at"  => "2014-02-21T10:22:53Z",
          "last_build_finished_at" => "2014-02-21T10:31:36Z"
        }
      ].to_json
      FakeWeb.register_uri(:get, "https://api.travis-ci.org/repos/#{ENV['JENKINS_ORG']}.json", :body => @json)
    end

    it "should return the five latest builds and create a list" do
      @result = TravisBuilds.update
      @result[:latest].count.should == 3
      @result[:latest][0][:job].should == "dashboards"
      @result[:latest][0][:date].should == "about 11 hours ago"
      @result[:latest][0][:status].should == "success"
      @result[:latest][1][:job].should == "breasal"
      @result[:latest][1][:date].should == "about 12 hours ago"
      @result[:latest][1][:status].should == "success"
      @result[:latest][2][:job].should == "csvlint"
      @result[:latest][2][:date].should == "about 13 hours ago"
      @result[:latest][2][:status].should == "disabled"
    end

    it "should return a success image, a state and EVERYTHING IS AWESOME" do
      result = TravisBuilds.build_images
      result[:image].should match /https:\/\/buildmemes.herokuapp.com\/p\?[0-9]+/
      result[:state].should == "pass"
      result[:trombone].should include('<source src="/awesome.mp3" type="audio/mpeg; codecs=\'mp3\'">')
      result[:trombone].should include('<source src="/awesome.ogg" type="audio/ogg; codecs=\'vorbis\'">')
    end

  end

  describe "with failing builds" do

    before :all do
      @json = [
        {
          "id"                     => 877145,
          "slug"                   => "theodi/dashboards",
          "description"            => "ODI dashboards, built using Dashing",
          "last_build_id"          => 19330461,
          "last_build_number"      => "103",
          "last_build_status"      => 0,
          "last_build_result"      => 0,
          "last_build_duration"    => 431,
          "last_build_language"    => nil,
          "last_build_started_at"  => "2014-02-21T12:43:51Z",
          "last_build_finished_at" => "2014-02-21T12:50:44Z"
        },
        {
          "id"                     => 1544293,
          "slug"                   => "theodi/breasal",
          "description"            => "A Ruby gem that converts GB and Irish Eastings and Northing to Latitude and Longitude",
          "last_build_id"          => 19329423,
          "last_build_number"      => "3",
          "last_build_status"      => 1,
          "last_build_result"      => 1,
          "last_build_duration"    => 121,
          "last_build_language"    => nil,
          "last_build_started_at"  => "2014-02-21T12:17:53Z",
          "last_build_finished_at" => "2014-02-21T12:18:44Z"
        },
        {
          "id"                     => 1732224,
          "slug"                   => "theodi/csvlint",
          "description"            => "",
          "last_build_id"          => 19324022,
          "last_build_number"      => "246",
          "last_build_status"      => nil,
          "last_build_result"      => nil,
          "last_build_duration"    => 523,
          "last_build_language"    => nil,
          "last_build_started_at"  => "2014-02-21T10:22:53Z",
          "last_build_finished_at" => "2014-02-21T10:31:36Z"
        }
      ].to_json
      FakeWeb.register_uri(:get, "https://api.travis-ci.org/repos/#{ENV['JENKINS_ORG']}.json", :body => @json)
    end

    it "should return failing builds" do
      @result = TravisBuilds.update
      @result[:failboat].count.should == 1
      @result[:failboat][0][:job].should == "breasal"
      @result[:failboat][0][:date].should == "about 12 hours ago"
      @result[:failboat][0][:status].should == "failure"
    end

    it "should return a fail image, a state and a sad trombone" do
      result = TravisBuilds.build_images
      result[:image].should match /https:\/\/buildmemes.herokuapp.com\/f\?[0-9]+/
      result[:state].should == "fail"
      result[:trombone].should include('<source src="/sadtrombone.mp3" type="audio/mpeg; codecs=\'mp3\'">')
      result[:trombone].should include('<source src="/sadtrombone.ogg" type="audio/ogg; codecs=\'vorbis\'">')
    end

  end

  after :all do
    Timecop.return
  end

end
