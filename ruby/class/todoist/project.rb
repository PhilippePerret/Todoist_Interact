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
    
    def initialize data = nil
      dispatch data unless data.nil?
    end
    
    ##
    #
    # Code HTML de sortie du projet
    #
    def html_output
      o = ""
      o << name
      o << "Parent : #{parent.name}" unless parent.nil?
      o << "Enfants : #{children.collect{|c| c.name}.join(', ')}" unless children.nil?
      unless taches.nil?
        taches.each do |tache|
          o << "<div>#{tache.echeance_sec} #{tache.content}</div>"
        end
      end
      return o
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