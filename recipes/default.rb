include_recipe "apt"

def setup(users)
  install_git_core

  users.each do |user|
    download_gitconfig(user)
  end
end

def install_git_core
  package "git-core" do
    options "--force-yes"
    action :upgrade
  end
end

def download_gitconfig(user)
  remote_file "Create .gitconfig" do
    path "/home/#{user}/.gitconfig"
    user user
    source "#{node['git']['gist']}"
    not_if { File.exists?("/home/#{user}/.gitconfig") }
  end
end

users = node['git']['users']

setup(users)
