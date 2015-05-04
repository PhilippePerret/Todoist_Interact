=begin

Ce script permet d'afficher le contenu de n'importe quelle donnée

=end

# Types des données à inspecter
types = [:items]


require_relative 'required'

Requete::new(:get, types).inspect
