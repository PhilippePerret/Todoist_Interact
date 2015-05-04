=begin

Class Todoist::Project
----------------------
Gestion des projets

=end
class Todoist
  class Project
    
    # Propriétés de Todoist
    # ---------------------
    attr_accessor :id                   # ID unique du projet
    attr_accessor :user_id              # UID du créateur du projet
    attr_accessor :name                 # Nom string du projet
    attr_accessor :color                # ID couleur ou couleur hex
    attr_accessor :is_deleted           # 0: non effacé, 1: effacé
    attr_accessor :collapsed            # 0: réduit, 1: déployé
    attr_accessor :item_order           # Classement dans liste des projets
    attr_accessor :indent               # Indentation (1 à 4)
    attr_accessor :shared               # true: partagé / false: non partagé
    attr_accessor :is_archived          # 0: non archivé, 1: archivé
    attr_accessor :archived_date        # NIL / date de l'archivage
    attr_accessor :archived_timestamp   # Tsp de l'archivage
    
    # Propriétés volatiles ajoutées au projet
    
    # Instance Todoist::Project du parent (if any)
    attr_accessor :parent
    # Instances Todoist::Project des enfants (if any)
    attr_accessor :children
    # Array des instances de tache (Todoist::Project::Tache)
    attr_accessor :taches
    # {Fixnum} Hauteur HTML du projet (en pixels)
    attr_accessor :html_height
    # {Fixnum} Décalage horizontal de la tache courante (en train
    # d'être affichée)
    attr_accessor :html_current_hoffset
    
    def initialize data = nil
      dispatch data unless data.nil?
    end
    
    ##
    #
    # Code HTML de sortie du projet
    #
    def to_html
      
      @html_current_hoffset = 0
      taches_html = ""
      unless taches.nil?
        taches.each do |tache|
          next if tache.due_date.nil?
          # TODO: Plus tard, il ne faudra pas passer les taches en retard mais
          # les mettre dans un style en exergue (rouge)
          next if tache.retard? # passer les taches en retard
          taches_html << tache.to_html
          incremente_taches_sorties
        end
      end
      
      ##
      ## Code retourné
      ##
      full_code_html = "<div class='project' style=''>" +
        "<div class='project_name'>#{name}</div>" +
        "<div class='taches'>#{taches_html}</div>" +
        children_as_html +
      "</div>"
      
      ##
      ## On retourne soit le code HTML construit, soit un code
      ## vide si le projet et ses sous-projets ne contiennent aucune
      ## tache à traiter
      ##
      if @nombre_taches.to_i > 0
        full_code_html
      else
        ""
      end
    end
    
    ##
    #
    # Méthode qui incrémente le nombre de taches de ce projet et
    # de son projet supérieur (if any)
    #
    def incremente_taches_sorties
      @nombre_taches ||= 0
      @nombre_taches += 1
      parent.incremente_taches_sorties unless parent.nil? # opération en chaine
    end
    
    ##
    #
    # Retourne le code HTML des projets enfants (if any)
    #
    def children_as_html
      return "" if children.nil?
      children.collect{ |sp| sp.to_html }.join
    end
    ##
    #
    # Ajoute une tache au projet (peuplement)
    #
    # +tache+ instance Todoist::Project::Tache de la tâche à 
    # ajouter au projet
    #
    def add_tache tache
      @taches ||= []
      @taches << tache
    end
    
    ##
    #
    # Ajoute un projet enfant
    #
    # +projet+ Instance Todoist::Project du projet enfant
    #
    def add_child projet
      @children ||= []
      @children << projet
    end
    
    def dispatch data
      data.each do |k, v| self.instance_variable_set("@#{k}", v) end
    end
  end
end