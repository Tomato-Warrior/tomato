module TasksHelper

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

end
