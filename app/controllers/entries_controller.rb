class EntriesController < ApplicationController
  def index
    @entries = Entry.find(:all)
  end

  def new
    @entry = Entry.new
  end
  def create
    @entry = Entry.new(params[:entry])
    if @entry.save
      redirect_to entries_path
    end
  end

  def edit
  end

  def show
    @entry = Entry.find(params[:id])
  end

end
