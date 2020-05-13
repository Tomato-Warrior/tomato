class TictacsController < ApplicationController
  before_action :last_tictac, only: [:index, :show]
  
  def index
  end

  def show
  end

  private 

  def last_tictac
    @tictac = current_user.tictacs.last    
  end

end
