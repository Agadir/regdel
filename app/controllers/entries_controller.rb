class EntriesController < InheritedResources::Base
  defaults :resource_class => controller_name.singularize.camelize.constantize, :collection_name => 'entries', :instance_name => 'entry'

  def collection
    controller_name.singularize.camelize.constantize.paginate(:page => params[:page])
  end

  def index 
    @entries = Entry.paginate(:page => params[:page])
  end
  def write_check
    # Bank to vendor, vendor to expense
    @entry = Entry.new
    @entry[:type] = 'Check'
    @entry.debits << Debit.new
    # Vendor matches with bank
    @company_accounts = Vendor.all
    @payable = Credit.new
    @proxy_transaction = Proxy.new
    @entry.credits << Credit.new
    # Vendor also matches with expense
    @debit_accounts = Expense.find(:all)
    @credit_accounts = BankAccount.find(:all)
    render :new
  end

  def transfer_funds 
    @entry = Entry.new
    @entry[:type] = 'Transfer'
    @entry.debits << Debit.new
    @entry.credits << Credit.new
    @debit_accounts = BankAccount.find(:all)
    @credit_accounts = BankAccount.find(:all)
    render :new
  end

  def create_invoice 
    @entry = Entry.new
    @entry[:type] = 'Invoice'
    @entry.credits << Credit.new
    @entry.debits << Debit.new
    @proxy_transaction = Proxy.new
    @company_accounts = Customer.all
    @debit_accounts = Revenue.find(:all)
    @credit_accounts = BankAccount.find(:all)
    @revenue_accounts = Revenue.all
    render :new
  end

  def create
    type = params[:entry][:type]
    params[:entry].delete(:type)
    @entry = type.capitalize.constantize.new(params[:entry])
    if @entry.save
      redirect_to entries_path
    else
      render :new
    end
  end
  def update
    entry_type = params[:type].downcase.to_sym
    @entry = Entry.find(params[:id])
    respond_to do |format|
      if @entry.update_attributes(params[entry_type])
        format.html { redirect_to(@entry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @business.errors, :status => :unprocessable_entity }
      end
    end
  end

end
