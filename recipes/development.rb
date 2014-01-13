node['git']['users'].each do |user|
  template "/home/#{user}/.gitconfig" do 
    source "gitconfig.erb"
    owner user
    mode "644"
    action :create_if_missing
  end
end
