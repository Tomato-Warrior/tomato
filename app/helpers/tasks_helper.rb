module TasksHelper
  def display_tag( tag_names )
    tag_names.map{|tag|"<span class='badge badge-light'>#{tag}</span>"}.join(' ').html_safe
  end
end
