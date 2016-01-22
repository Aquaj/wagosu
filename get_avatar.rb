require 'nokogiri'
require 'open-uri'
require 'json'
require 'octokit'
require_relative 'id'

client = Octokit::Client.new \
  :login    => ID.ids[0],
  :password => ID.ids[1],
  :auto_paginate => true

user = client.user
wagon = client.org_teams("lewagon")
members = client.team_members(901914)
avatars = members.map { |usr| usr["avatar_url"]}.each_with_index.map { |index, url| [index, url] }
avatars.each do |combo|
  open("media/avatar-#{combo[1].to_s.rjust(3,'0')}", 'wb') do |file|
    file << open(combo[0]).read
  end
end
