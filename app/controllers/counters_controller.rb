class CountersController < ApplicationController
  def index
  end
  def new
    @counter = Counter.new
  end

end
