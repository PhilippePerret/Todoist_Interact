=begin

Méthodes pour la construction du code de sortie des tâches

=end
class Todoist
class Project
class Tache
  
  ##
  #
  # Code HTML d'affichage de la tache
  #
  def to_html
    "<div class='tache priority#{priority}' style='#{html_style}'>#{content}</div>"
  end
  
  ##
  #
  # Données pour la balise style
  #
  def html_style
    sty = []
    # sty << "top:21px"
    unless due_date.nil?
      sty << "margin-left:#{html_left}px"
      sty << "width:#{html_width}px"
    else
      
    end
    sty.join(';')
  end
  
  ##
  #
  # Décalage gauche de la tache
  #
  # Soit elle part en même temps que la dernière tache du projet courant,
  # soit elle est au bout.
  #
  def html_left
    @html_left ||= begin
      project.html_current_hoffset
    end
  end
  def html_width
    @html_width ||= begin
      full_width = HtmlDocument::Cal::hpos( echeance_sec )
      full_width = 4 if full_width < 4
      w = full_width - project.html_current_hoffset
      project.html_current_hoffset += w
      w
    end
  end
end
end
end