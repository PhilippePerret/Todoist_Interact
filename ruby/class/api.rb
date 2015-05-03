
class Api
  
  HTTP  = "https://todoist.com/API/v6/sync"
  
  class << self
    
    # Se récupère dans l'application Todoist:
    # Outils (roue crantée) > "Paramètres de Todoist" > Compte > Clé API
    def token
      @token ||= data[:token]
    end
        
    def data
      @data ||= begin
        require "./data/secret/data_api"
        DATA_API
      end
    end
    
    ##
    # Return les data du user courant
    #
    def user
      @user ||= get_user
    end
    
    ##
    #
    # Récupère les données du user par curl
    #
    def get_user
      cmd = "curl -X POST #{HTTP} -d token=#{token} -d resource_types='[\"user\"]' -d seq_no=#{Requete::last_seq_no} -d seq_no_global=#{Requete::last_seq_no_global}"
    end
    
  end
end