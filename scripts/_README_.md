Ce dossier contient tous les scripts qu'on peut jouer

Tous les scripts doivent commencer par :

    require_relative 'required'
    
Noter que les scripts doivent être toujours appelés depuis le dossier Todoist_Interact, ce qui se fait naturellement depuis TextMate, mais si on est dans le Terminal, on doit faire :

    $ cd .../Todoist_Interact
    $ ruby ./scripts/le_script_a_lancer.rb