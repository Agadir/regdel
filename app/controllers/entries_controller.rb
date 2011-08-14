class EntriesController < InheritedResources::Base


  def write_check
    # Bank to vendor, vendor to expense
    @entry = Entry.new
    @entry[:type] = 'Check'
    @debits = [Debit.new]
    # Vendor matches with bank
    @company_accounts = Vendor.all
    @payable = Credit.new
    @proxy_transaction = Debit.new
    @credits = []
    1.times do
      @credits << Credit.new
    end
    # Vendor also matches with expense
    @debit_accounts = Expense.find(:all)
    @credit_accounts = BankAccount.find(:all)
    render :new
  end

  def transfer_funds 
    @entry = Entry.new
    @entry[:type] = 'Transfer'
    @debits = [Debit.new]
    @credits = [Credit.new]
    @debit_accounts = BankAccount.find(:all)
    @credit_accounts = BankAccount.find(:all)
    render :new
  end

  def create_invoice 
    @entry = Invoice.new.as_base
    @credits = Credit.new
    @debits = Debit.new
    @debit_accounts = Customer.find(:all)
    @credit_accounts = BankAccount.find(:all)
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

end
