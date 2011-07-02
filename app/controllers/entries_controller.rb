class EntriesController < ApplicationController
  def index
  end

  def new
    @entry = Entry.new
  end
  def create
    @entry = Entry.new(params[:entry])
  end

  def edit
  end

  def show
  end

end
