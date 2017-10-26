#!/bin/bash

# On initialise le choix avec une valeur
choix1=9

# Tant que l'utilisateur ne saisit pas 0, on reste dans l'application
while [[ choix1 -ne 0 ]]; do

    # On affiche le menu
    echo
    echo "Sélectionner l'action souhaitée :"
    echo -e "\t 1. Se déplacer vers un dossier"
    echo -e "\t 2. Afficher le contenu d'un fichier"
    echo -e "\t 3. Supprimer/Copier/Déplacer/Renommer un fichier"
    echo -e "\t 4. Créer/Supprimer/Déplacer/Renommer un dossier"
    echo -e "\t 5. Afficher une image"
    echo -e "\t 6. Chercher un mot dans un fichier"
    echo -e "\t 0. Quitter"
    echo

    # On écoute la saisie utilsiateur
    read -p "Choix : " choix1
    echo

    # En fonction de la saisie
    case $choix1 in

        #### 1. Déplacement dans un dossier ####
        1)
        # Si le dossier existe bien, on se déplace dans le dossier
        while [[ ! -d "$choix2" ]]; do
            read -p "Dossier de destination (0 pour revenir au menu principal) : " choix2
            echo
            # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
            if [ $choix2 -eq 0 ] 2> /dev/null; then
                echo "Retour au menu principal"
                echo
                break
            # Si c'est un dossier, on se déplace et on pwd et ls
            elif [ -d "$choix2" ]; then
                echo
                echo "Déplacement vers $choix2"
                cd $choix2
                pwd
                ls -la
                echo
                echo
                break
            # Sinon, choix inattendu, on retourne au menu principal
            else
                echo
                echo "Le dossier $choix2 n'existe pas, veuillez recommencer"
                read -p "Dossier de destination (0 pour revenir au menu principal) : " choix2
                echo
            fi
        done
        ;;

        #### 2. Afficher le contenu d'un fichier ####
        2)
        choix2=""
        # Si le fichier existe bien, on affichera son contenu
        while [[ ! -e "$choix2" ]]; do
            read -p "Fichier à afficher (0 pour revenir au menu principal) : " choix2
            echo
            # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
            if [ $choix2 -eq 0 ] 2> /dev/null; then
                echo "Retour au menu principal"
                echo
                break
            # Si c'est un fichier on affiche le contenu
            elif [ -e "$choix2" ]; then
                echo
                echo "Affichage du fichier $choix2"
                echo
                cat $choix2
                echo
                echo
                break
            # Sinon, choix inattendu, on retourne au menu principal
            else
                echo
                echo "Le fichier $choix2 n'existe pas, veuillez recommencer"
                read -p "Fichier à afficher (0 pour revenir au menu principal) : " choix2
                echo
            fi
        done
        ;;

        #### 3. Supprimer/Copier/Déplacer/Renommer un fichier ####
        3)
        choix2=9
        while [[ choix2 -ne 0 ]]; do
            # On affiche un sous-menu
            echo
            echo "Sélectionner l'action souhaitée :"
            echo -e "\t 1. Supprimer"
            echo -e "\t 2. Copier"
            echo -e "\t 3. Déplacer"
            echo -e "\t 4. Renommer"
            echo -e "\t 0. Retour au menu principal"
            echo
            read -p "Choix : " choix2
            echo

            case $choix2 in
                1)
                read -p "Fichier à supprimer (0 pour revenir au menu principal) : " choix3
                # Si le fichier existe bien, on le supprimera
                if [ -e "$choix3" ]; then
                    echo
                    echo "Suppression du fichier $choix3"
                    rm $choix3
                    echo
                    echo
                    break
                # Retour en arrière
                elif [ $choix3 -eq 0 ] 2> /dev/null; then
                    echo "Retour au menu précédent"
                    echo
                    break
                # Sinon, choix inattendu, on retourne au menu principal
                else
                    echo "Le fichier $choix3 n'existe pas, retour au menu précédent"
                fi
                ;;
                2)
                read -p "Fichier à copier (0 pour revenir au menu principal) : " choix3
                # Si le fichier existe bien, on le écoute la destination souhaitée
                if [ -e "$choix3" ]; then
                    echo "Copie du fichier $choix3"

                    # Tant que $choix4 ne contient pas de vrai dossier
                    while [[ ! -d "$choix4" ]]; do
                        read -p "Dossier de destination (0 pour revenir au menu principal) : " choix4
                        # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
                        if [ $choix4 -eq 0 ] 2> /dev/null; then
                            echo "Retour au menu principal"
                            echo
                            break
                        # Si la destination est bien un dossier on effectue la copie
                        elif [ -d "$choix4" ]; then
                            echo "Copie de $choix3 vers $choix4"
                            cp -ra $choix3 "$choix4/$choix3-$(date +"%d-%m-%y-%r")"
                            echo
                            echo
                            break
                        # Sinon, choix inattendu, on retourne au menu principal
                        else
                            echo "Le dossier $choix4 n'existe pas, veuillez recommencer"
                        fi
                    done
                # Retour en arrière
                elif [ $choix3 -eq 0 ] 2> /dev/null; then
                    echo "Retour au menu précédent"
                    echo
                    break
                # Sinon, choix inattendu, on retourne au menu principal
                else
                    echo "Le fichier $choix3 n'existe pas, retour au menu précédent"
                    echo
                fi
                ;;
                3)
                read -p "Fichier à déplacer (0 pour revenir au menu principal) : " choix3
                # Si le fichier existe bien, on le écoute la destination souhaitée
                if [ -e "$choix3" ]; then
                    echo "Déplacement du fichier $choix3"

                    # Tant que $choix4 ne contient pas de vrai dossier
                    while [[ ! -d "$choix4" ]]; do
                        read -p "Dossier de destination (0 pour revenir au menu principal) : " choix4
                        # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
                        if [ $choix4 -eq 0 ] 2> /dev/null; then
                            echo "Retour au menu principal"
                            echo
                            break
                        # Si la destination est bien un dossier on effectue le déplacement
                        elif [ -d "$choix4" ]; then
                            echo "Déplacement de $choix3 vers $choix4"
                            mv $choix3 "$choix4/$choix3"
                            echo
                            echo
                            break
                        # Sinon, choix inattendu, on retourne au menu principal
                        else
                            echo "Le dossier $choix4 n'existe pas, veuillez recommencer"
                        fi
                    done
                # Retour en arrière
                elif [ $choix3 -eq 0 ] 2> /dev/null; then
                    echo "Retour au menu principal"
                    echo
                    break
                # Sinon, choix inattendu, on retourne au menu principal
                else
                    echo "Le fichier $choix3 n'existe pas, retour au menu précédent"
                    echo
                fi
                ;;
                4)
                read -p "Fichier à renommer (0 pour revenir au menu principal) : " choix3
                # Si le fichier existe bien, on écoute le nouveau nom souhaité
                if [ -e "$choix3" ]; then
                    echo "Renommage du fichier $choix3"

                    # On impose un nom de fichier alphanumérique
                    while [[ ! $choix4 =~ ^[a-zA-Z0-9]+$ ]]; do
                        read -p "Nouveau nom (0 pour revenir au menu principal) : " choix4
                        # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
                        if [ $choix4 -eq 0 ] 2> /dev/null; then
                            echo "Retour au menu principal"
                            echo
                            break
                        # Si le nouveau nom est correcte (alphanumérique), on renomme
                        elif [[ $choix4 =~ ^[a-zA-Z0-9]+$ ]]; then
                            echo "Renommage de $choix3 en $choix4"
                            mv $choix3 $choix4
                            echo
                            echo
                            break
                        # Sinon, choix inattendu, on retourne au menu principal
                        else
                            echo "Nouveau nom incorrecte, veuillez utiliser des caractères alphanumériques"
                        fi
                    done
                # Retour en arrière
                elif [ $choix3 -eq 0 ] 2> /dev/null; then
                    echo "Retour au menu principal"
                    echo
                    break
                # Sinon, choix inattendu, on retourne au menu principal
                else
                    echo "Le fichier $choix3 n'existe pas, retour au menu précédent"
                    echo
                fi
                ;;
                0)
                # On quitte dans le cas 0
                echo "Retour au menu principal"
                echo
                break
                ;;
                *)
                echo "Je n'ai pas compris votre choix"
                echo
                ;;
            esac
        done
        ;;

        #### "4. Créer/Supprimer/Déplacer/Renommer un dossier" ####
        4)
        choix2=9
        while [[ choix2 -ne 0 ]]; do
            # On affiche un sous-menu
            echo
            echo "Sélectionner l'action souhaitée :"
            echo -e "\t 1. Créer un dossier"
            echo -e "\t 2. Supprimer un dossier"
            echo -e "\t 3. Déplacer un dossier"
            echo -e "\t 4. Renommer un dossier"
            echo -e "\t 0. Retour au menu principal"
            echo
            read -p "Choix : " choix2
            echo

            case $choix2 in
                # 1. Créer un dossier
                1)
                read -p "Nom du dossier à créer : " choix3
                if [[ $choix3 =~ ^[a-zA-Z0-9]+$ ]]; then
                    echo "Création du dossier $choix3"
                    mkdir $choix3
                    echo
                    echo
                    break
                elif [ $choix3 -eq 0 ] 2> /dev/null; then
                    echo "Retour au menu principal"
                    echo
                    break
                # Sinon, choix inattendu, on retourne au menu principal
                else
                    echo "Nouveau nom incorrecte, veuillez utiliser des caractères alphanumériques"
                fi
                ;;
                # 2. Supprimer un dossier
                2)
                read -p "Nom du dossier à supprimer (0 pour revenir au menu principal) : " choix3
                # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
                if [ $choix3 -eq 0 ] 2> /dev/null; then
                    echo "Retour au menu principal"
                    echo
                    echo
                    break
                # Si c'est un dossier, on le supprime (pas trop de danger car non sudo)
                elif [ -d "$choix3" ]; then
                    echo "Suppression du dossier $choix3"
                    rm -rf $choix3
                    echo
                    echo
                    break
                # Sinon, choix inattendu, on retourne au menu principal
                else
                    echo "Le dossier $choix3 n'existe pas, retour au menu précédent"
                    echo
                fi
                ;;
                # 3. Déplacer un dossier
                3)
                read -p "Nom du dossier à déplacer (0 pour revenir au menu principal) : " choix3
                # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
                if [ $choix3 -eq 0 ] 2> /dev/null; then
                    echo "Retour au menu principal"
                    echo
                    echo
                    break
                # Si c'est un dossier, on demande la destination
                elif [ -d "$choix3" ]; then
                    # Tant que $choix4 ne contient pas de vrai dossier
                    while [[ ! -d "$choix4" ]]; do
                        read -p "Dossier de destination (0 pour revenir au menu principal) : " choix4
                        # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
                        if [ $choix4 -eq 0 ] 2> /dev/null; then
                            echo "Retour au menu principal"
                            echo
                            break
                        # Si la destination est bien un dossier on effectue le déplacement
                        elif [ -d "$choix4" ]; then
                            echo "Déplacement de $choix3 vers $choix4"
                            mv $choix3 $choix4
                            echo
                            echo
                            break
                        # Sinon, choix inattendu, on invite à recommencer
                        else
                            echo "Le dossier $choix4 n'existe pas, veuillez recommencer"
                        fi
                    done
                # Sinon, choix inattendu, on retourne au menu principal
                else
                    echo "Le dossier $choix3 n'existe pas, retour au menu précédent"
                    echo
                fi
                ;;
                # 4. Renommer un dossier
                4)
                read -p "Nom du dossier à renommer (0 pour revenir au menu principal) : " choix3
                # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
                if [ $choix3 -eq 0 ] 2> /dev/null; then
                    echo "Retour au menu principal"
                    echo
                    echo
                    break
                # Si c'est un dossier, on demande le nouveau nom
                elif [ -d "$choix3" ]; then
                    # Tant que $choix4 ne contient pas une chaine valide (alphanumerique)
                    while [[ ! $choix4 =~ ^[a-zA-Z0-9]+$ ]]; do
                        read -p "Nouveau nom de dossier (0 pour revenir au menu principal) : " choix4
                        # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
                        if [ $choix4 -eq 0 ] 2> /dev/null; then
                            echo "Retour au menu principal"
                            echo
                            break
                        # Si le nouveau nom est correcte on renomme le dossier
                        elif [[ $choix4 =~ ^[a-zA-Z0-9]+$ ]]; then
                            echo "Renommage du dossier $choix3 en $choix4"
                            mv $choix3 $choix4
                            echo
                            echo
                            break
                        # Sinon, choix inattendu, on invite à recommencer
                        else
                            echo "Le nouveau nom du dossier $choix3 doit être alphanumerique, veuillez recommencer"
                        fi
                    done
                # Sinon, choix inattendu, on retourne au menu principal
                else
                    echo "Le dossier $choix3 n'existe pas, retour au menu précédent"
                    echo
                fi
                ;;
                0)
                # On quitte dans le cas 0
                echo "Retour au menu principal"
                echo
                break
                ;;
                *)
                echo "Je n'ai pas compris votre choix"
                echo
                ;;
            esac
        done
        ;;

        #### "5. Afficher une image" ####
        5)
        choix2=""
        # Si le fichier existe bien, on va vérifier son extension
        while [[ ! -e "$choix2" ]] || ([[ ! ($choix2 == *.jpg || $choix2 == *.jpeg || $choix2 == *.png || $choix2 == *.gif) ]]); do
            read -p "Nom de l'image à afficher  (0 pour revenir au menu principal) : " choix2
            # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
            if [ $choix2 -eq 0 ] 2> /dev/null; then
                echo "Retour au menu principal"
                echo
                break
            # Si c'est un fichier on affiche le contenu
            elif [[ $choix2 == *.jpg ]] || [[ $choix2 == *.jpeg ]] || [[ $choix2 == *.png ]] || [[ $choix2 == *.gif ]]; then
                echo "Affichage de l'image $choix2"
                xdg-open $choix2
                echo
                echo
                break
            # Sinon si le fichier existe mais n'est pas une image
            elif [ -e "$choix2" ]; then
                echo "Le fichier $choix2 existe mais n'est pas une image, veuillez recommencer"
                echo
            # Sinon, choix inattendu, on invite à ressaisir
            else
                echo "Le fichier $choix2 n'existe pas, veuillez recommencer"
                echo
            fi
        done
        ;;

        #### "6. Chercher un mot dans un fichier" ####
        6)
        read -p "Fichier à parcourir (0 pour revenir au menu principal) : " choix2
        # Si le fichier existe bien, on le parcourt
        if [ -e "$choix2" ]; then
            # On demande la chaine à rechercher
            read -p "Mot à retrouver (0 pour revenir au menu principal) : " choix3
            # Si l'utilisateur saisit 0, on vire le message d'erreur de typage et on quitte le while
            if [ $choix3 -eq 0 ] 2> /dev/null; then
                echo "Retour au menu précédent"
                echo
                break
            # Sinon, si la chaine est alphanumerique, on lance la recherche
            elif [[ $choix3 =~ ^[a-zA-Z0-9]+$ ]]; then
                echo "Recherche du mot $choix3 dans le fichier $choix2"
                echo
                grep -nw $choix2 -e $choix3
                echo
                echo
            # Sinon, choix inattendu, on retourne au menu précédent
            else
                echo "Le mot $choix3 n'est pas alphanumerique, retour au menu précédent"
            fi
        # Retour en arrière
        elif [ $choix2 -eq 0 ] 2> /dev/null; then
            echo "Retour au menu précédent"
            echo
            break
        # Sinon, choix inattendu, on retourne au menu principal
        else
            echo "Le fichier $choix2 n'existe pas, retour au menu précédent"
        fi
        ;;

        #### Choix 0, on quitte ####
        0)
        echo "Au revoir"
        break
        ;;

        #### S'il fait un choix inexistant, on demande de saisir à nouveau ####
        *)
        echo "Je n'ai pas compris votre choix, veuillez recommencer"
        read -p "Choix : " choix1
        ;;
    esac
done
