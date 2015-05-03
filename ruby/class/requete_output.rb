=begin

Gestion de la sortie HTML de la requête

=end
class Requete
  
  attr_reader :doc_html
  
  def output
    
    doc = HtmlDocument::new
    @doc_html = doc
    
    ## Extrait juste les éléments voulus
    doc.body_content = body_content_by_type

    ## Fabrique le fichier HTML
    doc.write
    
    ## Ouvre le fichier HTML
    doc.open
    
  end
  
  ##
  #
  # Retourne le contenu du body en fonction du type et des paramètres
  # de sortie définis
  #
  def body_content_by_type
    b = ""
    case params[:type].first
    when :projects
      b << Todoist::Project::html_body_content(self)
    else
      b << doc_html.div("Ce contenu n'est pas encore traité")
    end
  rescue Exception => e
    @error = e
    return output_on_error
  else
    return b
  end
  
  ##
  #
  # Code body retourné en cas d'erreur
  #
  def output_on_error
    doc_html.div(error.message) + doc_html.div(error.backtrace.collect{|e| doc_html.div(e)}.join("\n"))
  end
  
end