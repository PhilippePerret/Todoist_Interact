=begin

Méthodes pour la construction du code de sortie des tâches

=end
class Todoist
class Project
class Tache
  
  COLOR_BY_PRIORITY = {
    1 =>    'transparent',
    2 =>    'cyan',
    3 =>    'blue',
    4 =>    'red'
  }
  
  ##
  #
  # Code HTML d'affichage de la tache
  #
  def to_html
    "<div class='tache' style='#{html_style}'>#{content}</div>"
  end
  
  ##
  #
  # Données pour la balise style
  #
  def html_style
    sty = []
    sty << "top:21px"
    sty << "background-color:#{COLOR_BY_PRIORITY[priority]}"
    unless due_date.nil?
      sty << "left:#{html_left}px"
      sty << "width:#{html_width}px"
    else
      
    end
    sty.join(';')
  end
  
  def html_left
    @html_left ||= project.html_current_hoffset
  end
  def html_width
    @html_width ||= begin
      hpos = HtmlDocument::Cal::hpos(echeance_sec)
      w = hpos - project.html_current_hoffset
      project.html_current_hoffset += w
      w
    end
  end
end
end
end