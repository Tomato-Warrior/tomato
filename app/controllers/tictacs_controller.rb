class TictacsController < ApplicationController
  before_action :last_tictac, only: [:index, :show]
  
  def index
  end

  def show
  end

  private 

  def last_tictac  
    if current_user.tictacs.count == 0
      @tictac = Tictac.new
    else
      @tictac = current_user.tictacs.last
    end 
      
  end
end
