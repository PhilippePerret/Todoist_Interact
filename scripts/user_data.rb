=begin
  Script qui retourne les données de l'user
=end
require_relative 'required'

Requete::new( :get, [:user]).inspect
