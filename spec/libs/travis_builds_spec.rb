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
          "last_build_status"      => 0,
          "last_build_result"      => 0,
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
      expect(@result[:latest].count).to eq(3)
      expect(@result[:latest][0][:job]).to eq("dashboards")
      expect(@result[:latest][0][:date]).to eq("about 11 hours ago")
      expect(@result[:latest][0][:status]).to eq("success")
      expect(@result[:latest][1][:job]).to eq("breasal")
      expect(@result[:latest][1][:date]).to eq("about 12 hours ago")
      expect(@result[:latest][1][:status]).to eq("success")
      expect(@result[:latest][2][:job]).to eq("csvlint")
      expect(@result[:latest][2][:date]).to eq("about 13 hours ago")
      expect(@result[:latest][2][:status]).to eq("success")
    end

    it "should return a success image, a state and EVERYTHING IS AWESOME" do
      result = TravisBuilds.build_images
      expect(result[:image]).to match /https:\/\/buildmemes.herokuapp.com\/p\?[0-9]+/
      expect(result[:state]).to eq("build-passed")
      expect(result[:trombone]).to include('<source src="/awesome.mp3" type="audio/mpeg; codecs=\'mp3\'">')
      expect(result[:trombone]).to include('<source src="/awesome.ogg" type="audio/ogg; codecs=\'vorbis\'">')
    end

    it "should ignore specified builds" do
      ENV['TRAVIS_IGNORE_REPOS'] = "theodi/csvlint"

      @result = TravisBuilds.update
      expect(@result[:latest].count).to eq(2)

      ENV['TRAVIS_IGNORE_REPOS'] = ''
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
          "last_build_status"      => 0,
          "last_build_result"      => 0,
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
      expect(@result[:failboat].count).to eq(1)
      expect(@result[:failboat][0][:job]).to eq("breasal")
      expect(@result[:failboat][0][:date]).to eq("about 12 hours ago")
      expect(@result[:failboat][0][:status]).to eq("failure")
    end

    it "should return a fail image, a state and a sad trombone" do
      result = TravisBuilds.build_images
      expect(result[:image]).to match /https:\/\/buildmemes.herokuapp.com\/f\?[0-9]+/
      expect(result[:state]).to eq("build-failed")
      expect(result[:trombone]).to include('<source src="/sadtrombone.mp3" type="audio/mpeg; codecs=\'mp3\'">')
      expect(result[:trombone]).to include('<source src="/sadtrombone.ogg" type="audio/ogg; codecs=\'vorbis\'">')
    end

  end

  describe "with a build in progress" do

    before :all do
      @json = [{
        "id" => 877145,
        "slug" => "theodi/dashboards",
        "description" => "ODI dashboards, built using Dashing",
        "last_build_id" => 24166451,
        "last_build_number" => "278",
        "last_build_status" => nil,
        "last_build_result" => nil,
        "last_build_duration" => nil,
        "last_build_language" => nil,
        "last_build_started_at" => "2014-02-21T12:43:51Z",
        "last_build_finished_at" => nil
      }].to_json
      FakeWeb.register_uri(:get, "https://api.travis-ci.org/repos/#{ENV['JENKINS_ORG']}.json", :body => @json)
    end

    it "should return failing builds" do
      result = TravisBuilds.update
      expect(result[:failboat].count).to eq(0)
      expect(result[:latest][0][:job]).to eq("dashboards")
      expect(result[:latest][0][:date]).to eq("about 11 hours ago")
      expect(result[:latest][0][:status]).to eq("building")
    end

  end

  describe "with an errored build" do

    before :all do
      @json = [{
        "id"                     => 877145,
        "slug"                   => "theodi/dashboards",
        "description"            => "ODI dashboards, built using Dashing",
        "last_build_id"          => 19330461,
        "last_build_number"      => "103",
        "last_build_status"      => nil,
        "last_build_result"      => nil,
        "last_build_duration"    => 431,
        "last_build_language"    => nil,
        "last_build_started_at"  => "2014-02-21T12:43:51Z",
        "last_build_finished_at" => "2014-02-21T12:50:44Z"
      }].to_json
      FakeWeb.register_uri(:get, "https://api.travis-ci.org/repos/#{ENV['JENKINS_ORG']}.json", :body => @json)
    end

    it "should return errored builds" do
      result = TravisBuilds.update
      expect(result[:failboat].count).to eq(1)
      expect(result[:failboat][0][:job]).to eq("dashboards")
      expect(result[:failboat][0][:date]).to eq("about 11 hours ago")
      expect(result[:failboat][0][:status]).to eq("error")
    end

  end

  after :all do
    Timecop.return
  end

end
