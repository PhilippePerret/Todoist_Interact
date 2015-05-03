=begin

Class Todoist::Project::Tache
-----------------------------
Méthodes de classe

=end
class Todoist
class Project
class Tache
  class << self
    
    ##
    ## Liste de toutes les taches (instances Todoist::Project::Tache)
    ## avec en clé l'ID de la tâche et en valeur son instance
    ##
    attr_accessor :list
    
    def peuple requete
      
      ##
      ## Liste des tâches
      ##
      @list = {}
      requete.result[:Items].each do |tache_data|
        tache = new tache_data
        prj = Todoist::projects[tache.project_id]
        next if prj.nil? # une erreur qui peut arriver
        tache.project = prj
        prj.add_tache tache
        @list.merge! tache.id => tache_data
      end
      
      ##
      ## On classe les taches dans les projets
      ##
      Todoist::projects.each do |pid, projet|
        next if projet.taches.nil?
        projet.taches = projet.taches.sort_by{ |t| t.echeance_sec.to_i }
      end
      
    end
  end
end
end
end