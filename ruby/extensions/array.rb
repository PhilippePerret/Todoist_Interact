class Array
  
  def pretty_inspect retrait

    # Définition du retrait
    retrait = case retrait
    when Fixnum   then "  " * retrait
    when String   then retrait
    else ""
    end
    
    next_retrait = retrait + '  '
    "[\n#{retrait}" + 
    self.collect{ |e|
      case e
      when Hash, Array
        e.pretty_inspect(next_retrait)
      else
        e.inspect
      end
    }.join("\n#{retrait}") + 
    "\n#{retrait}]\n"
  end
  
end