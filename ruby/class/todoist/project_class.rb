=begin

Class Todoist::Project
----------------------
Gestion des projets

Méthodes de classe

=end
class Todoist
  class Project
    
    class << self
      
      ##
      #
      # Retourne le contenu HTML pour l'affichage des projets
      #
      # +requete+ Instance Requete de la requête qui a récupéré les projets
      #
      def html_body_content requete
        projets = requete.result[:Projects].collect{ |data_projet| new data_projet }
        apparentize projets
        
        # Sortie HTML
        projets.collect do |projet|
          next if projet.indent > 1
          requete.doc_html.div( projet.html_output, class: 'projet' )
        end.join("\n")
      end
    
      ##
      #
      # Classe et imbrique les projets
      #
      # Par défaut, la liste des projets ne contient aucune hiérarchie. On sait
      # qu'un projet appartient à un autre seulement en testant son index 
      # (item_order) et son indentation (indent)
      # Cette méthode de classe permet d'ajouter une propriété au projet
      # définissant son parent et ses enfants
      #
      # +projets+   Liste des instances Todoist::Project des projets
      #
      def apparentize projets
        current_indent = 1
        current_projet = { 1 => nil, 2 => nil, 3 => nil, 4 => nil }
        projets.sort_by{|p| p.item_order }.each do |projet|

          ## Tous les projets courants de niveau supérieur doivent être
          ## remis à nil
          (projet.indent..4).each do |i| current_projet[i] = nil end
          
          ## On met le projet courant de ce niveau
          current_projet[projet.indent] = projet
          
          if projet.indent > 1
            # => Projet imbriqué quel qu'il soit
            
            ## On règle son parent
            his_parent    = current_projet[projet.indent - 1]
            projet.parent = his_parent
            his_parent.add_child projet
          end
          
          current_indent = projet.indent
        end
      end
    
    end
    
  end
end