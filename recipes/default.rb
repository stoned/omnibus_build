logdir = node['omnibus']['build_dir'] + '/.kitchen/logs'

execute 'bundle install' do
  cwd node['omnibus']['build_dir']
  command "bundle install > #{logdir}/#{node['hostname']}-bundle-install.log 2>&1"
end

execute 'build project' do
  cwd node['omnibus']['build_dir']
  command "bundle exec omnibus build #{node['omnibus']['build_project']} > #{logdir}/#{node['hostname']}-build-project.log 2>&1"
end
