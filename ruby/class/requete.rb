=begin

Class Requete
-------------
Pour le traitement d'une requête cUrl

=end

require 'json'
require 'securerandom' # Pour générer les UUID

class Requete
  
  API_HTTP  = Api::HTTP
  def self.api_http; API_HTTP end
  
  API_TOKEN = Api::token
  def self.api_token; API_TOKEN end
  
  # Les types d'objets dans Todoist
  OBJECT_TYPES = {
    :all            => {},
    :user           => {},
    :users          => {},
    :collaborators  => {},
    :projects       => {},
    :items          => {},
    :notifications  => {},
    :reminders      => {},
    :daily_orders   => {},
    :labels         => {},
    :filters        => {}
  }
  
  class << self
    
    attr_writer :last_seq_no
    attr_writer :last_seq_no_global
    
    ##
    #
    # Le dernier numéro de séquence reçu, pour définir
    # seq_no et seq_no_global
    #
    def last_seq_no
      @last_seq_no ||= 0
    end
    def last_seq_no_global
      @last_seq_no_global ||= 0
    end
    
  end # << self
  
  attr_reader :type
  attr_reader :params
  attr_reader :error
  
  ##
  #
  # Initialise une requête du type voulu
  #
  def initialize type, params = nil
    @type   = type
    @params = real_params params
    check_types
  end
  
  # Conforme les paramètres envoyés en argument
  def real_params params
    case params
    when Symbol   then { type: [params] }
    when Array    then { type: params.collect{|e| e.to_sym} }
    when String   then { type: [params.to_sym] }
    when NilClass then { type: [:all] }
    when Hash
      params[:type] = [params[:type]] if params.has_key?(:type) && params.class != Array
      params
    else
      raise "Mauvais paramètre envoyé. Doit être un Hash, un Array de type, un type symbol ou un type string"
    end
  end
  
  # Vérifie que les types d'objets soit valides
  def check_types
    params[:type].each do |ty|
      raise "Le type d'objet #{ty.inspect} est inconnu" unless OBJECT_TYPES.has_key?(ty)
    end
  end
  
  ##
  #
  # Pour inspecter le résultat de la requête
  # (même en cas d'erreur)
  #
  def inspect
    res = result
    unless res.nil?
      puts res.pretty_inspect
    else
      puts "# ERREUR: #{error.message}"
      puts error.backtrace.join("\n")
    end
  end
  
  ##
  #
  # Joue la requête et retourne le résultat sous forme
  # d'une table json
  # Retourne NIL en cas d'erreur et place l'erreur dans @error
  #
  def result
    @result ||= begin
      res = `#{requete}`
      res = JSON.parse( res, { :symbolize_names => true } )
      Requete::last_seq_no        = res[:seq_no]
      Requete::last_seq_no_global = res[:seq_no_global]
    rescue Exception => e
      @error = e
      nil
    else
      res
    end
  end
  alias :run :result
  
  ##
  #
  # La requête construite
  #
  # Produit `curl etc.'
  #
  def requete
    rq = 'curl'
    rq << " -X POST"
    rq << " --silent"
    rq << " #{Requete::api_http}"
    rq << " -d seq_no=#{Requete::last_seq_no}"
    rq << " -d seq_no_global=#{Requete::last_seq_no_global}"
    rq << " -d token=#{API_TOKEN}"
    rq << (' ' + requete_params)
    debug "Requête:: #{rq}"
    return rq
  end
  
  ##
  #
  # Les paramètres de la requête en fonction de son type
  #
  def requete_params
    pms = send("params_requete_#{type}")    
    # On met en forme pour la commande curl
    pms.collect do |name, value|
      "-d #{name}=#{value}"
    end.join(" ")
  end
  
  # ---------------------------------------------------------------------
  #
  #   Les paramètres suivant le type de requête
  #
  # ----------------------------------------------------------------------
  
  def params_requete_get
    debug "params : #{params.inspect}"
    types = params[:type]
    types = [types] unless types.class == Array
    types = types.collect{ |e| e.to_s }
    types = types.inspect
    # return { resource_types: "'[\"#{params[:type]}\"]'" }
    return { resource_types: "'#{types}'" }
  end
  
  def params_requete_create
    
  end
  
  def params_requete_set
    
  end
  
  def params_requete_delete
    
  end
end