=begin

Class HtmlDocument
------------------
Classe permettant de construire le document HTML

=end
class HtmlDocument
  
  OUTPUT_FOLDER = File.join('.', 'output')
  
  class << self
    
    ##
    #
    # Hauteur pour le projet courant
    #
    def next_height_for_project
      @current_height_project ||= -59 # pour commencer à 1
      @current_height_project += 60
    end
    
  end # << self
  
  attr_accessor :body_content
  
  # Retourne le texte +str+ dans un div avec les attributs +attrs+
  def div str, attrs = nil
    attrs ||= {}
    "<div #{attrs.collect{|att,val| att.to_s+'=\"'+val.to_s+'\"'}.join(' ')}>#{str}</div>"
  end
  
  def title
    "Titre du document du #{Time.now}" # pour le moment
  end
  
  ##
  #
  # Ouvre le fichier
  #
  def open
    `open "#{path}"`
  end
  
  ##
  #
  # Ecrit le fichier
  #
  def write
    File.open(path, 'wb'){ |f| f.write whole }
  end
  
  def whole
    <<-HTML
<!DOCTYPE html>
<html>
#{entete}
#{body}
</html>
    HTML
  end
  
  def body
    <<-HTML
<body>
  <div><a href="todoist://">Ouvrir Todoist</a></div>
  <div id='calendrier'>
    #{body_content}
    <div style="clear:both"></div>
  </div>
</body>
    HTML
  end
  def entete
    <<-HTML
<head>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8">
  <title>#{title}</title>
  #{css}
</head>
    HTML
  end
  
  def css
    Dir["./data/output/html/**/*.css"].collect do |p|
      "<link rel='stylesheet' href='.#{p}' type='text/css' media='screen'>"
    end.join("\n")
  end
  
  # ---------------------------------------------------------------------
  
  def path
    @path ||= File.join(OUTPUT_FOLDER, name)
  end
  
  def name
    @name ||= "#{Time.now.to_i}.html"
  end
end