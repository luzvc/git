#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2013, Bubble
#
include_recipe "apt"

package "git-core"

node['git']['users'].each do |user_hash_key, user_hash|
  template "/home/vagrant/.gitconfig" do
    source "gitconfig.erb"
    owner user_hash_key
    mode "644"
    action :create_if_missing
    variables({
      :name => user_hash[:name],
      :email => user_hash[:email],
      :github => user_hash[:github]
    })
  end
end
