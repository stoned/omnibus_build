logdir = node['omnibus']['build_dir'] + '/.kitchen/logs'
env_gem = 'env BUNDLE_IGNORE_CONFIG=1 BUNDLE_PATH=$HOME/.bundle'

execute 'bundle install' do
  cwd node['omnibus']['build_dir']
  command <<-EOF.gsub(/\s+/, ' ').strip!
    sudo -i -u #{node['omnibus']['build_user']} \
    bash -l -c 'test -f ~#{node['omnibus']['build_user']}/load-omnibus-toolchain.sh && \
    . ~#{node['omnibus']['build_user']}/load-omnibus-toolchain.sh; \
    cd #{node['omnibus']['build_dir']}; \
    #{env_gem} bundle install > #{logdir}/#{node['hostname']}-bundle-install.log 2>&1'
    EOF
end

execute 'build project' do
  cwd node['omnibus']['build_dir']
  command <<-EOF.gsub(/\s+/, ' ').strip!
    sudo -i -u #{node['omnibus']['build_user']} \
    bash -l -c 'test -f ~#{node['omnibus']['build_user']}/load-omnibus-toolchain.sh && \
    . ~#{node['omnibus']['build_user']}/load-omnibus-toolchain.sh; \
    cd #{node['omnibus']['build_dir']}; \
    #{env_gem} bundle exec omnibus build #{node['omnibus']['build_project']} > #{logdir}/#{node['hostname']}-build-project.log 2>&1'
    EOF
end
