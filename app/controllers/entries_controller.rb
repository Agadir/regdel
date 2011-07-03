class EntriesController < InheritedResources::Base

  def write_check
    @entry = Check.new
    render :new
  end
  def transfer_funds 
    @entry = Transfer.new
    render :new
  end
end
