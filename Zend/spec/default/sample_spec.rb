require 'spec_helper'

describe package('httpd'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('httpd'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe service('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe service('org.apache.httpd'), :if => os[:family] == 'darwin' do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end


#
# Custom
#
context 'yumrepo resource type' do
  describe yumrepo('epel') do
    it { should exist }
    it { should be_enabled }
  end

  describe yumrepo('remi') do
    it { should exist }
    it { should_not be_enabled }
  end

  %w(vim-enhanced git php php-mbstring mysql-server).each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end
end


context 'PHP config resource type' do
  describe command('php -v') do
    its(:stdout) { should match /^PHP 5\.5\./ }
  end

  # describe package('php') do
  #   it { should be_installed.with_version "5.5" }
  # end

  # describe 'PHP config' do
  #   context php_config('date.timezone') do
  #     its(:value) { should eq 'Asia/Tokyo' }
  #   end
  # end
end


context 'Host resource type' do
  describe host('php.local') do
    it { should be_resolvable.by('hosts') }
  end

  # VirtualHost setting
  describe file('/etc/httpd/conf/httpd.conf') do
    it { should be_file }
    %w(php zf1 zf2).each do |h|
      its(:content) { should match /ServerName #{h}.local/ }
      its(:content) { should match /DocumentRoot \/vagrant\/www\/#{h}\/public/ }
    end
  end
end


context 'PHP Framework resource type' do
  # Composer package
  %w(php zf1 zf2).each do |h|
    describe file("/vagrant/www/#{h}/public/index.php") do
      it { should be_file }
    end
  end
end
