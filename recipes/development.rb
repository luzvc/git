node['git']['users'].each do |user|
  template "/home/#{user}/.gitconfig" do
    source "gitconfig.erb"
    owner user
    mode "644"
    action :create_if_missing
  end

  remote_file "Create .gitconfig" do
    path "/home/#{user}/.gitconfig"
    user user
    source "#{node['vim']['gist']}"
    not_if { File.exists?("/home/#{user}/.gitconfig") }
  end
end
