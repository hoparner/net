#!/bin/bash

#Ցանցի սկանավորման script by:legion_603

#Սահմանեք գունային փոփոխականներ
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\e[34m'
NC='\033[0m' # Գույն չկա


echo -e "${RED}  ■■■■■■■■■■■■ \n ${BLUE} ■■■■■■■■■■■■ \n ${ORANGE} ■■■■■■■■■■■■"
echo -e "${RED}Բարի գալուստ ${NC}IP ${RED}և ${NC}WiFi ${NC}Scaner ${RED}leg${BLUE}ion${ORANGE}_603 ${NC}"
echo -e "${BLUE}Telegram: https://t.me/hoparner ${NC} "

#Ընտրեք լեզուն մեկնարկի ընտրացանկի համար
echo "Выберите язык:"
echo "1. Armenian"
echo "2. Russian"
echo "3. English"
read -p "Выберите язык (1-3): " choice

case $choice in
1)
echo -e "${ORANGE}Մուտքագրեք ցանցի IP միջավայրի միջակայքը (օրինակ՝ 192.168.1.0/24): ${NC}"
;;
2)
echo -e "${ORANGE}Введите диапазон IP-адресов сети (например, 192.168.1.0/24): ${NC}"
;;
3)
echo -e "${ORANGE}Enter the network IP range (e.g., 192.168.1.0/24): ${NC}"
;;
*)
echo -e "${RED}Неверный выбор, выход...${NC}"
exit 1
;;
esac

#Ստացեք ցանցի IP տիրույթը

read ip_range

#Կատարեք ցանցի սկանավորում

echo -e "${RED}Подождите, запрос обрабатывается...${NC}"
spinner() {
local pid=$!
local delay=0.15
local spinstr='|/-'
while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
local temp=${spinstr#?}
printf "[%c]" "$spinstr"
local spinstr=$temp${spinstr%"$temp"}
sleep $delay
printf "\b\b\b"
done
}
(nmap -sn $ip_range | grep "Nmap scan report" | awk '{print $NF}' > devices.txt) & spinner

#Տպեք սկանավորման արդյունքները

case $choice in
1)
echo -e "${GREEN}Ցանցում գտնվող սարքերը՝${NC}"
;;
2)
echo -e "${GREEN}Устройства в сети:${NC}"
;;
3)
echo -e "${GREEN}Devices on the network:${NC}"
;;
esac

if [ -s "devices.txt" ]; then
    while IFS= read -r device; do
        echo -e "${GREEN}Устройства сохранены ${RED} devices.txt ${NC} ${ORANGE} $device ${NC}"

    done < devices.txt
else
    case $choice in
    1)
    echo -e "${RED}Չի գտնվել սարքեր։${NC}"
    ;;
    2)
    echo -e "${RED}Не найдены устройства.${NC}"
    ;;
    3)
    echo -e "${RED}No devices found.${NC}"
    ;;
    esac
fi