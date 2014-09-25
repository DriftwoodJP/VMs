#
# Cookbook Name:: zend
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

service "iptables" do
  action [:stop, :disable]
end

%w{vim-enhanced git}.each do |p|
  package p do
    action :install
  end
end

bash "add_yum_repo" do
  user "root"
  cwd "/vagrant/www"
  code <<-EOH
  sudo rpm -Uvh http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/i386/epel-release-6-8.noarch.rpm
  sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
  sudo yum install -y --enablerepo=remi-php55 php php-mbstring httpd mysql-server
  EOH
end

service "httpd" do
  action [:start, :enable]
end

template "httpd.conf" do
  path   "/etc/httpd/conf/httpd.conf"
  source "httpd.conf.erb"
  mode   0644
  notifies :restart, 'service[httpd]'
end
