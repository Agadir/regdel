class EntriesController < InheritedResources::Base

  def write_check
    @entry = Check.new.becomes(Account)
    @debits = [Debit.new]
    @credits = []
    3.times do
      @credits << Credit.new
    end
    @debit_accounts = Expense.find(:all)
    @credit_accounts = BankAccount.find(:all)
    render :new
  end

  def transfer_funds 
    @entry = Transfer.new
    @debits = [Debit.new]
    @credits = []
    3.times do
      @credits << Credit.new
    end
    @debit_accounts = BankAccount.find(:all)
    @credit_accounts = BankAccount.find(:all)
    render :new
  end

  def create_invoice 
    @entry = Invoice.new
    @credits = Credit.new
    @debits = Debit.new
    @debit_accounts = Customer.find(:all)
    @credit_accounts = BankAccount.find(:all)
    render :new
  end

  def create
    type = params[:entry][:type]
    @entry = type.constantize.new(params[:entry])
    if @entry.save
      redirect_to entries_path
    else
      render :new
    end
  end

end
