include_recipe "apt"

def setup(users, gist)
  install_git_core

  users.each do |user|
    download_gitconfig(user, gist)
  end
end

def install_git_core
  package "git-core" do
    options "--force-yes"
    action :upgrade
  end
end

def download_gitconfig(user, gist)
  if gist && gist.length > 0
    remote_file "Create .gitconfig" do
      path "/home/#{user}/.gitconfig"
      user user
      source gist
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

users = node[:git][:users]
gist = node[:git][:gist]

setup(users, gist)
