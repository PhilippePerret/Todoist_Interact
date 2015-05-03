=begin

Class Todoist::Project::Tache
-----------------------------
Instance d'une tache

=end
class Todoist
  class Project
    class Tache
      
      ## Propriété de Todoist
      ## --------------------
      attr_accessor :id                 # ID de la tache
      attr_accessor :project_id         # ID du projet possesseur
      attr_accessor :content            # Contenu textuel de la tache
      attr_accessor :due_date           # La date d'échéance
      attr_accessor :due_date_utc       # Idem au format UTC
      attr_accessor :checked            # Coché ? 0: non / 1: oui
      attr_accessor :priority           # Priorité (de 1 à 4)
      attr_accessor :item_order         # Ordre dans la liste
      attr_accessor :indent             # Indentation (de 1 à 4)
      attr_accessor :collapse           # 0: réduit / 1: étendue
      attr_accessor :user_id            # ID de propriétaire
      attr_accessor :is_archived        # 0: non archivé / 1:archivé
      attr_accessor :is_deleted         # 0:non effacé / 1: effacé
      attr_accessor :assigned_by_uid    # ID de l'user assignant
      attr_accessor :sync_id            # ?
      attr_accessor :responsible_uid    # ?
      
      ##
      ## Propriétés volatiles de la tache
      ##
      attr_accessor :project        # Instance Todoist::Project du projet
      attr_accessor :echeance       # {Date} Date d'échéance
      attr_accessor :echeance_sec   # {Fixnum} échéance en nombre de secondes
      
      def initialize data = nil
        dispatch data unless data.nil?
        variable_volatiles_set
      end
      
      def variable_volatiles_set
        
        ##
        ## Transformation de l'échéance en format Date et seconde
        ##
        ## Note: Seulement si la tâche a une date d'échéance
        ##
        unless due_date.nil? # tache sans échéance
          @echeance = Date::parse(due_date)
          @echeance_sec = @echeance.to_time.to_i
        end
      end
      
      def dispatch data
        data.each do |k, v| self.instance_variable_set("@#{k}", v) end
      end
      
    end
  end
end