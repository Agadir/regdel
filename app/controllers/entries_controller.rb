class EntriesController < InheritedResources::Base

  def write_check
    @entry = Check.new
    @credits = Credit.new
    @debits = Debit.new
    @accounts = BankAccount.find(:all)
    render :new
  end
  def transfer_funds 
    @entry = Transfer.new
    @credits = Credit.new
    @debits = Debit.new
    @accounts = BankAccount.find(:all)
    render :new
  end
  def create
    if params.has_key?(:transfer)
      @entry = Transfer.new(params[:transfer])
    end
    if params.has_key?(:check)
      @entry = Check.new(params[:check])
    end
    if @entry.save
      redirect_to entries_path
    end
  end
end
