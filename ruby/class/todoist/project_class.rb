=begin

Class Todoist::Project
----------------------
Gestion des projets

Méthodes de classe

=end
class Todoist
  
  class << self # Todoist
    ## Tous les projets courants
    ## En clé, leur identifiant, en valeur l'instance Todoist::Project du 
    ## projet
    attr_accessor :projects
  end # << self Todoist
  
  class Project
    
    class << self
      
      ##
      ## La requête courante
      ##
      attr_reader :requete
      
      ##
      #
      # Retourne le contenu HTML pour l'affichage des projets
      #
      # +requete+ Instance Requete de la requête qui a récupéré les projets
      #
      def html_body_content requete
        
        ##
        ## On donne à connaitre la requête
        ##
        @requete = requete
        
        ##
        ## Si les types d'objet ne contiennent pas les tâches, il faut les
        ## ajouter avant d'appeler la requête
        ##
        requete.params[:type] << :items unless requete.params[:type].include? :items
        
        ## Pour voir
        # debug requete.result.pretty_inspect
        
        ##
        ## On prend les projets de la requête pour les transformer en instances
        ## Todoist::Project et peupler Todoist::projects
        ##
        peuple
        
        ##
        ## On prend les tâches pour peupler les données
        ## On ajoute les tâches aux projets, etc.
        ##
        Todoist::Project::Tache::peuple requete
                
        # Sortie HTML
        Todoist::projects.collect do |pid, projet|
          next if projet.indent > 1
          projet.to_html
        end.join("\n")
      end
      
      ##
      #
      # Peuple les projets courant, c'est-à-dire :
      #   - crée des instances Todoist::Project
      #   - peuple la donnée Todoist::projects
      #   - crée les parentés entre les projets (appartenances)
      #
      def peuple
        Todoist::projects = {} 
        requete.result[:Projects].collect do |data_projet| 
          p = new data_projet
          Todoist::projects.merge! p.id => p
        end
        apparentize
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
      def apparentize
        current_indent = 1
        current_projet = { 1 => nil, 2 => nil, 3 => nil, 4 => nil }
        Todoist::projects.sort_by{|pid, p| p.item_order }.each do |pid, projet|

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