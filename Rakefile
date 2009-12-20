require 'rubygems'
require 'xml/libxslt'
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
    xslt.parameters = { 'account_submit' => '/account/submit' }
    html = xslt.serve
    File.open('public/s/xhtml/account_form.html', 'w') {|f| f.write(html) }
end





task :test do
  
end


task :create_dummy_accounts do
  load('scripts/default_accounts.rb')

end

task :create_dummy_entries do
  require 'data/regdel_dm'
  for i in 1..20
      mycents = rand(8)
      @entry = Entry.new(:memorandum => "Hi #{i}",:entered_on => Time.now.to_i)
      @entry.save
      @entry.credits.create(:amount => RdMoney.new("#{i}.0#{mycents}").no_d, :account_id => 1)
      @entry.debits.create(:amount => RdMoney.new("#{i}.0#{mycents}").no_d, :account_id => 2)
  end
end




Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = Dir.glob('spec/*_spec.rb')
  t.spec_opts << '--format specdoc'
  t.rcov = true
end

task :default => :spec
