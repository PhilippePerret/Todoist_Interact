=begin

Gestion de la sortie HTML de la requête

=end
class Requete
  
  attr_reader :doc_html
  
  def output
    
    doc = HtmlDocument::new
    @doc_html = doc
    
    ## Résultat de la requête
    r = result
    
    unless r.nil?
      ## Extrait juste les éléments voulus
      doc.body_content = body_content_by_type
    else
      doc.body_content = output_on_error
    end
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
    debug result.pretty_inspect
    case params[:type].first
    when :projects
      Todoist::Project::html_body_content self
    else
      doc_html.div("Ce contenu n'est pas encore traité")
    end
  end
  
  ##
  #
  # Code body retourné en cas d'erreur
  #
  def output_on_error
    doc.div(error.message) + doc.div(error.backtrace.collect{|e| doc.div(e)}.join("\n"))
  end
  
end