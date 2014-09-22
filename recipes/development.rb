node['git']['users'].each do |user|
  remote_file "Create .gitconfig" do
    path "/home/#{user}/.gitconfig"
    user user
    source "#{node['git']['gist']}"
    not_if { File.exists?("/home/#{user}/.gitconfig") }
  end
end
