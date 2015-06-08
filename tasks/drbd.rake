task :drbd do
  runcmd :apt, 'install', 'drbd8-utils'
end
