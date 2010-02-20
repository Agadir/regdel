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
require 'rake'
require 'spec/rake/spectask'


task :test => :spec
task :default => :spec

namespace :files do
  @nomsg = 'src or data file(s) updated, rebuilding target'

  def with(value)
    yield(value)
  end

  def render_markdown(src,target)
    require 'rdiscount'
    text = open(src).read
    markdown = RDiscount.new(text)
    thehtml = '<div>' + markdown.to_html + '</div>'
    File.open(target, 'w') {|f| f.write(thehtml) }
  end

  with('public/s/xhtml/welcome.html') do |target|
    thesrc = 'README.md'
    thexml = '/tmp/tmp.xml'
    thexsl = 'views/xsl/xhtml_to_xhtml_blocks.xsl'
    render_markdown(thesrc,thexml)

    file target => [thexml, thexsl] do
      params = { 'h2_title' => 'Welcome to Regdel' }
      transform(thexml,thexsl,params,target)
    end
    desc "Build welcome.html from README.rd"
    task :welcome_html => target
  end

  with('public/s/xhtml/account_form.html') do |target|
    thexml = 'data/accounting_data_model.xml'
    thexsl = 'lib/xsl/account_model_to_xhtml_form.xsl'
    file target => [thexml, thexsl] do
      xslt.parameters = { 'account_submit' => './submit' }
      transform(thexml,thexsl,params,target)
    end
    desc "Account form is built from data model"
    task :account_form => target
  end

  with('data/account_types.rb') do |target|
    thexml = 'public/s/xml/raw/account_types.xml'
    thexsl = 'lib/xsl/account_types2many.xsl'
    file target => [thexml, thexsl] do
      params = { 'format' => 'ruby' }
      transform(thexml,thexsl,params,target)
    end
    desc "Build ruby array of account types"
    task :account_types => target
  end

  with('public/s/js/account_types.js') do |target|
    thexml = 'public/s/xml/raw/account_types.xml'
    thexsl = 'lib/xsl/account_types2many.xsl'
    file target => [thexml, thexsl] do
      params = { 'format' => 'json' }
      transform(thexml,thexsl,params,target)
    end
    desc "Build json array of account types"
    task :account_types_json => target
  end

  with('public/s/xml/raw/account_types_select.xml') do |target|
    thexml = 'public/s/xml/raw/account_types.xml'
    thexsl = 'lib/xsl/account_types_to_xml.xsl'
    file target => [thexml, thexsl] do
      params = { 'format' => 'select' }
      transform(thexml,thexsl,params,target)
    end
    desc "Build select array of account types"
    task :account_types_select => target
  end

  with('public/d/css/style.css') do |target|
    thesass = 'views/css/regdel.sass'

    desc "Publish style.css"
    task :stylesheet => target
  end

  def transform(xml,xsl,params,target,msg=@nomsg)
    require 'xml/xslt'
    xslt = XML::XSLT.new()
    puts msg
    xslt.xml = xml
    xslt.xsl = xsl
    xslt.parameters = params
    html = xslt.serve
    File.open(target, 'w') {|f| f.write(html) }
  end

  file '/tmp/schema2dm.xsl' do
    require 'open-uri'
    filecontent = open('http://github.com/docunext/0945a8a54c/raw/master/xsl/schema2dm.xsl').read
    File.open('/tmp/schema2dm.xsl', 'w') {|f| f.write(filecontent) }
  end

  with('data/regdel_dm_tmp.rb') do |target|
    thexml = 'data/accounting_data_model.xml'
    thexsl = '/tmp/schema2dm.xsl'
    file target => [thexml, thexsl] do
      transform(thexml,thexsl,params,target)
    end
    desc "Build DataMapper model"
    task :datamapper_model_tmp => target
  end

end



task :create_dummy_db do
  load('scripts/default_accounts.rb')
end

task :create_dummy_accounts do
  load('scripts/default_accounts.rb')
end

task :create_dummy_entries do
  require 'regdel'
  for i in 1..20
      mycents = rand(8)
      @entry = Entry.new(:memorandum => "Hi #{i}",:entered_on => Time.now.to_i)
      @entry.save
      @myamt = @entry.credits.create(:amount => Regdel::RdMoney.new("#{i}.0#{mycents}").no_d, :account_id => 1)
      @myamt.save
      @myamt = @entry.debits.create(:amount => Regdel::RdMoney.new("#{i}.0#{mycents}").no_d, :account_id => 2)
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
    run 'chmod 0777 /var/www/dev/regdel/current/public/d/xhtml'
  end
  task :deploy => [:update, :restart]
end


Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = Dir.glob('spec/*_spec.rb')
  t.spec_opts << '--format specdoc'
  t.rcov = true
  t.rcov_opts = ['--exclude', '/var/lib/gems/1.8/gems,/usr/bin/spec,spec']
end





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
