#!/bin/bash

RED='\e[31m'
BLUE='\033[36m'
GREEN='\033[32m'
RESET='\033[0m'
BOLD="\e[1m"

User=$(whoami)

if [[ $User != "root" ]]; then
    echo ""
    echo -e "${BOLD}${RED} ¡¡¡ Run as root !!! ${RESET}"  
    echo ""
    echo -e "Try: ${BOLD}${GREEN}sudo ./namefile.sh ${RESET}${RESET}"
    echo ""
else
    if [[ -d "/etc/netplan/" ]]; then
        file=$(ls /etc/netplan)
        start(){
            clear

            # Hacer bucle para aviso de delete file

            # echo -e "${RED}Warning: This script empty netplan's file and rewrites it${RESET}"
            # echo ""
            # echo "1 --> Sure, start: "
            # echo "2 --> No, exit: "
            # echo ""
            # read -p "Select "


            echo ""
            echo -e "     ${GREEN}Welcome to Netplan${RESET}"

            if [[ $1 -eq 1 ]]; then
                echo ""
                echo -e " ${RED}¡¡¡ Incorrect card name !!!${RESET}"
            fi

            echo ""
            echo -e "${BLUE}Select which card to configure:${RESET}"
            echo ""

            delimiter=$(ip a | grep "state UP\|state DOWN" | cut -d ' ' -f 2 | cut -d ':' -f 1 | wc -l)
            cont=1

            while [ $cont -le $delimiter ]; do
                echo -e "${BLUE}$cont${RESET} ${RED}-->${RESET} ${GREEN}"$(ip a | grep "state UP\|state DOWN" | cut -d ' ' -f 2 | cut -d ':' -f 1 | awk 'NR=='$cont'')${RESET}
                cont=$(($cont + 1))
            done

            echo -e "${BLUE}$cont${RESET} ${RED}-->${RESET} ${GREEN}Exit (Type: end)"${RESET}
            echo ""
            read -p "Write the card you want to configure: " card

            if [[ $card == "end" ]]; then
                end
            elif [[ "$card" ]]; then
                $(ip a | grep "state UP\|state DOWN" | grep -w "$card" &> /dev/null)
            else
                $(ip /a &> /dev/null)
            fi
        }

        lookfor(){
            echo "Buscando..."
        }

        start 0

        while [ $? -eq 1 ]; do
            start 1
        done

        lookfor
        
    else
        echo "${RED}Netplan's directory not found, exiting ... ${RESET}"
    fi
fi