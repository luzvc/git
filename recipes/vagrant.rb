template "/home/vagrant/.gitconfig" do
  source "gitconfig.erb"
  owner "vagrant"
  mode "644"
  action :create_if_missing
end
