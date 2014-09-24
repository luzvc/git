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
  if node['git']['gist']
    remote_file "Create .gitconfig" do
      path "/home/#{user}/.gitconfig"
      user user
      source "#{node['git']['gist']}"
      not_if { File.exists?("/home/#{user}/.gitconfig") }
    end
  else
    template "/home/#{user}/.gitconfig" do
      source "gitconfig.erb"
      owner user
      mode "644"
      action :create_if_missing
    end
  end
end

users = node['git']['users']

setup(users)
