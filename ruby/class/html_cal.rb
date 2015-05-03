=begin

Class Html::Cal
---------------
Méthodes gestion du calendier


=end
class HtmlDocument
  class Cal
    
    CAL_WIDTH = 1200 # nombre de pixels en largeur
    
    PERIODE_DAYS = 15 # nombre de jours de la période affichée
    
    class << self
      
      attr_accessor :periode_days
      
      ##
      ## Période couverte par le calendrier affiché (en secondes)
      ## Défaut : 15 jours
      ##
      attr_accessor :periode
      def periode
        @periode ||= ((@periode_days || PERIODE_DAYS) * 24 * 3600)
      end
      
      ##
      # Retourne la position horizontale correspondant au temps en 
      # secondes +secs+, en considérant la largeur de la page (CAL_WIDTH) et
      # la position du jour courant comme bord gauche
      def hpos secs
        ((secs - now) * coef_s2p).to_i
      end
      
      ##
      # Le temps courant en secondes du jour (vrai début du jour)
      #
      def now
        @now ||= begin
          now = Time.now
          Time.new(now.year, now.month, now.day).to_i
        end
      end
      
      ##
      # Le temps maximum affiché (30 jours)
      #
      def max_time
        @max_time ||= now + periode
      end
      
      
      ##
      #
      # Le coefficiant de transformation des secondes en pixels
      #
      # <nombre secondes> * coef_s2p = <nombre pixels>
      #
      def coef_s2p
        coef_s2p ||= (CAL_WIDTH.to_f / periode)
      end
      
    end # << self
    
  end
end