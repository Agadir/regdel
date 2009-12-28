###
# Program: http://www.regdel.com
# Component: Rakefile
# Copyright: Savonix Corporation
# Author: Albert L. Lash, IV
# License: Gnu Affero Public License version 3
# http://www.gnu.org/licenses
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, see http://www.gnu.org/licenses
# or write to the Free Software Foundation, Inc., 51 Franklin Street,
# Fifth Floor, Boston, MA 02110-1301 USA
##
require 'rubygems'
require 'xml/xslt'
require 'rake'
require 'spec/rake/spectask'

task :default do
    puts "hi"
end

task :publish_account_form => 'public/s/xhtml/account_form.html'

file 'public/s/xhtml/account_form.html' => ['data/accounting_data_model.xml', 'views/xsl/account_model_to_xhtml_form.xsl'] do
    xslt = ::XML::XSLT.new()
    xslt.xml = 'data/accounting_data_model.xml'
    xslt.xsl = 'views/xsl/account_model_to_xhtml_form.xsl'
    xslt.parameters = { 'account_submit' => '../../account/submit' }
    html = xslt.serve
    File.open('public/s/xhtml/account_form.html', 'w') {|f| f.write(html) }
end



task :account_types => 'data/account_types.rb'

file 'data/account_types.rb' => ['public/s/xml/raw/account_types.xml', 'views/xsl/account_types2many.xsl'] do
    xslt = ::XML::XSLT.new()
    xslt.xml = 'public/s/xml/raw/account_types.xml'
    xslt.xsl = 'views/xsl/account_types2many.xsl'
    xslt.parameters = { 'format' => 'ruby' }
    html = xslt.serve
    File.open('data/account_types.rb', 'w') {|f| f.write(html) }
end
# do the same with json:
# xsltproc --stringparam format json views/xsl/account_types2many.xsl 
# public/s/xml/raw/account_types.xml > public/s/js/account_types.json



task :test => :spec


task :create_dummy_accounts do
  load('scripts/default_accounts.rb')

end

task :create_dummy_entries do
  require 'data/regdel_dm'
  for i in 1..20
      mycents = rand(8)
      @entry = Entry.new(:memorandum => "Hi #{i}",:entered_on => Time.now.to_i)
      @entry.save
      @myamt = @entry.credits.create(:amount => RdMoney.new("#{i}.0#{mycents}").no_d, :account_id => 1)
      @myamt.save
      @myamt = @entry.debits.create(:amount => RdMoney.new("#{i}.0#{mycents}").no_d, :account_id => 2)
      @myamt.save
  end
end


begin
  require "vlad"
  Vlad.load(:app => nil, :scm => "git")
rescue LoadError
  # do nothing
end

namespace :vlad do
  remote_task :restart do
    run "sudo svc -d /service/regdel"
    run "sudo svc -u /service/regdel"
  end
end


Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = Dir.glob('spec/*_spec.rb')
  t.spec_opts << '--format specdoc'
  t.rcov = true
  t.rcov_opts = ['--exclude', '/var/lib/gems/1.8/gems,/usr/bin/spec,spec']
end



task :default => :spec


require 'rdoc'
require 'rdoc/rdoc'
require 'rdoc/generator'
require 'rdoc/generator/darkfish'
require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
    rdoc.title    = "Regdel - Ruby Powered Bookkeeping Software"
    #rdoc.rdoc_files.include 'README.md'
    rdoc.rdoc_files.include 'regdel.rb'
    rdoc.rdoc_files.include 'data/*.rb'

    rdoc.options += [
        '-SHNU',
        '-f', 'darkfish',
      ]
end

if File.exists?('myrake')
    load('myrake')
end
