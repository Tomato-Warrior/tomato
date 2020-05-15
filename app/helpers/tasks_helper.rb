module TasksHelper
  def display_tag( tag_names )
    tag_names.map{|tag|"<span class='badge tag-color'>#{tag}</span>"}.join(' ').html_safe
  end
end
