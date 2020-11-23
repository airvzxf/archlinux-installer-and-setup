#!/bin/bash +xv

echo -e "~~~~~~~~~~~ START THE SERVICE TO RUN REFLECTOR ~~~~~~~~~~~"
echo ""

while [ 1 ]
do
 if ping -c 1 google.com >> /dev/null 2>&1
 then
  echo -e "~~~~~~~~~~~ RUN THE REFLECTOR PACKAGE ~~~~~~~~~~~"
  echo -e "*** Yes! The Internet is available. ***"
  echo -e "*** $(date)  |  $(date -u) ***"
  echo ""

  FILE="/etc/pacman.d/mirrorlist"
  FILE_TEMP="/tmp/.mirrorlist-tmp"

  reflector --verbose --threads 8 --country "United States" --protocol https --completion-percent 100 --age 72 --score 8 --sort rate --save "${FILE_TEMP}"
  echo ""
  echo ""

  INDEX=0
  SERVERS=()
  TIMER=()

  while IFS= read -r LINE
  do
    if [[ "${LINE}" == Server* ]]
    then
    echo "${LINE}"
    echo "${LINE}" > "${FILE}"
    SERVERS[${INDEX}]=$(echo "${LINE}")
    TIME=$({ time pacman -Syy --noconfirm ; } 2>&1 | grep real | sed "s/real\s*//")
    TIMER[${INDEX}]=${TIME}
    echo "INDEX: ${INDEX}"
    echo "SERVERS[${INDEX}]: ${SERVERS[${INDEX}]}"
    echo "TIMER[${INDEX}]: ${TIMER[${INDEX}]}"
    echo ""
    INDEX=$((INDEX+1))
    fi
  done < "${FILE_TEMP}"

  rm -f "${FILE_TEMP}"

  echo ""
  echo "SERVERS: ${#SERVERS[@]}"
  echo "TIMER: ${TIMER[@]}"

  if [[ "${INDEX}" -gt 0 ]]
  then
    echo ""
    echo ""
    SMALLEST="${TIMER[0]}"
    SMALLEST_INDEX=0
    for (( i=1; i<${INDEX}; i++ ))
    do
    if [[ "${TIMER[${i}]}" < "${SMALLEST}" ]]
    then
      echo "SMALLEST:"
      SMALLEST_INDEX=${i}
      SMALLEST="${TIMER[${i}]}"
    fi
    echo "${TIMER[${i}]}  ->  ${SERVERS[${i}]}"
    done

    echo ""
    echo ""
    echo "${SERVERS[${SMALLEST_INDEX}]}"
    echo "${SERVERS[${SMALLEST_INDEX}]}" > "${FILE}"

    echo ""
    time pacman -Syy --noconfirm

    echo ""
    pacman -Su --noconfirm

    echo ""
    pacman -Rns $(pacman -Qtdq) --noconfirm

    echo ""
    sudo -u wolf yay -Sau --noconfirm
  fi

  break
 fi

 echo "systemctl service, reflector: No internet available."
 sleep 1
done
