module TasksHelper

  def project
    @project = current_user.projects.find(params[:id])
  end

  def display_tag( tag_names )
    tag_names.map{|tag|"<span class='badge tag-color mx-1'>#{tag}</span>"}.join(' ').html_safe
  end

  def display_expect_tictac( tictac_num )
    if tictac_num != nil
      i = 0
      expect_tictac = ''
      while i < tictac_num
        i += 1
        expect_tictac << "<img src='/expect_tictac.png' style='max-width:20px'>"
      end
      expect_tictac.html_safe
    end
  end

  def display_finished_tictac( tictac_num )
    if tictac_num != nil
      i = 0
      finished_tictac = ''
      while i < tictac_num
        i += 1
        finished_tictac << "<img src='/finish_tictac.png' style='max-width:20px'>"
      end
      finished_tictac.html_safe
    end
  end

  def display_cancelled_tictac( tictac_num )
    if tictac_num != nil
      i = 0
      cancelled_tictac = ''
      while i < tictac_num
        i += 1
        cancelled_tictac << "<img src='/cancel_tictac.png' style='max-width:20px'>"
      end
      cancelled_tictac.html_safe
    end
  end

end
