logdir = node['omnibus']['build_dir'] + '/.kitchen/logs'

execute 'bundle install' do
  cwd node['omnibus']['build_dir']
  command <<-EOF.gsub(/\s+/, ' ').strip!
    sudo -i -u #{node['omnibus']['build_user']} \
    bash -l -c 'cd #{node['omnibus']['build_dir']}; \
    bundle install > #{logdir}/#{node['hostname']}-bundle-install.log 2>&1'
    EOF
end

execute 'build project' do
  cwd node['omnibus']['build_dir']
  command <<-EOF.gsub(/\s+/, ' ').strip!
    sudo -i -u #{node['omnibus']['build_user']} \
    bash -l -c 'cd #{node['omnibus']['build_dir']}; \
    bundle exec omnibus build #{node['omnibus']['build_project']} > #{logdir}/#{node['hostname']}-build-project.log 2>&1'
    EOF
end
