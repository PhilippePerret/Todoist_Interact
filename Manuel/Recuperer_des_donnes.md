#Récupération de données

Scénario

    requete = Requete::new :get[, <data>]
    
##Exemples

###Récupération par symbol

    requete = Requete::new :get, :user
    requete.result
    # => Retourne les données de l'utilisateur


    requete = Requete::new :get, :projects
    requete.result
    # => Retourne les données de tous les projets

###Récupération par hash, avec filtre
    
    requete = Requete::new :get, {type: :projects, archived: true}
    requete.result
    # => Données des projets archivés

###Récupération par Array (plusieurs types)

    requete = Requete::new :get, [:projects, :users]
    requete.result
    # => Données des projets et des utilisateurs
    
###Récupération pour hash avec plusieurs types

    requete = Requete::new :get, { type: [:projects, :items], after: <date> }
    requete.result
    # => Données des projets et des tâches après la date <date>
    
    
##Types de données récupérables

Toutes les données récupérables sont celles définies par Todoist

    :users            L'utilisateur courant
    :projects         Tous les projets
    :items            Toutes les tâches
    :labels           Tous les labels
    :filters          Tous les filtres
    :day_orders       ???
    :reminders        Tous les rappels
    :collaborators    Tous les collaborateurs
    :notifications    Toutes les notifications
    
    
##Filtre de recherche

Liste des filtres possibles

    :after          Ne renvoie que les éléments qui doivent être effectués
                    après cette date (comprise) ou qui ont été créés après cette date
                    defaut: NIL
                    type:   string de type "DD-MM-[AA]AA"
    :before         Ne renvoie que les éléments à effectuer avant cette date ou créés
                    avant cette date
                    defaut: NIL
                    type:   string de type "DD-MM-[AA]AA"
    :deleted        Si true, ne renvoie que les éléments effacés
                    FALSE par défaut
    :archived       Si true ne renvoie que les éléments archivés
                    defaut: FALSE
    :in_history     Si true, renvoie seulement les tâches qui sont accomplies
                    defaut: FALSE
    :order          Le classement dans la liste
                    defaut: NIL
                    values: 1 à X
    :min_indent     Ne renvoie que les éléments possédant au moins cette identation
                    defaut: NIL
                    values: 1 à 4
    :max_indent     Ne renvoie que les éléments possédant au moins cette identation
                    defaut: NIL
                    values: 1 à 4