class Time
  
  ##
  #
  # Retourne le temps du début du jour du temps
  #
  def debut_jour
    Time.new(self.year, self.month, self.day)
  end
  
  ##
  #
  # Retourne le temps du début du lendemain
  #
  def debut_lendemain
    debut_jour + 3600*24
  end
end
