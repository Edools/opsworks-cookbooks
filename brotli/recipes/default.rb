Chef::Log.info('Installing brotli')

execute "installing unzip" do
  command "sudo apt-get install unzip"
end

execute "installing cmake" do
  command "sudo apt-get -y install cmake"
end

execute "downloading brotli" do
  command "wget https://github.com/google/brotli/archive/master.zip"
end

execute "unziping brotli" do
  command "unzip master.zip"
end

execute "preparing to compile brotli" do
  command "./configure-cmake"
  cwd "brotli-master"
end

execute "compilling brotli" do
  command "make"
  cwd "brotli-master"
end

execute "installing brotli" do
  command "sudo make install"
  cwd "brotli-master"
end


Chef::Log.info('Finishing install brotli')
