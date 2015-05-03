=begin

Class HtmlDocument
------------------
Classe permettant de construire le document HTML

=end
class HtmlDocument
  
  OUTPUT_FOLDER = File.join('.', 'output')
  
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
  #{body_content}
</body>
    HTML
  end
  def entete
    <<-HTML
<head>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8">
  <title>#{title}</title>
</head>
    HTML
  end
  
  # ---------------------------------------------------------------------
  
  def path
    @path ||= File.join(OUTPUT_FOLDER, name)
  end
  
  def name
    @name ||= "#{Time.now.to_i}.html"
  end
end