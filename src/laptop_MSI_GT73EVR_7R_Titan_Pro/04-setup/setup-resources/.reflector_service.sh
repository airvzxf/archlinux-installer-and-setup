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

    # --------------------------------------
    # Reflector: Request the servers and
    #   stores to the temporal folder.
    # --------------------------------------
    reflector --verbose --threads 8 --country "United States" --protocol https --completion-percent 100 --age 72 --score 8 --sort rate --save "${FILE_TEMP}"
    echo ""
    echo ""

    # --------------------------------------
    # Mirrorlist: Store all the servers and
    #   download rate into the array.
    # --------------------------------------
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
    echo "No. of SERVERS: ${#SERVERS[@]}"
    echo "TIMER:          ${TIMER[@]}"
    echo ""
    echo ""

    # --------------------------------------
    # Array: Get the smallest time.
    # --------------------------------------

    if [[ "${INDEX}" -gt 0 ]]
    then
      # --------------------------------------
      # Real Time: Extract the real time
      #   separate by minutes.
      # --------------------------------------
      INDEX=0
      MINUTES=()

      echo "# Get minutes:"
      echo ""
      for TIME in "${TIMER[@]}"
      do
        echo "$TIME"
        MINUTES[${INDEX}]=$(echo "$TIME" | sed -E "s/([0-9]*)m.*/\1/")
        INDEX=$(( INDEX + 1 ))
      done
      echo ""
      echo "MINUTES:   ${MINUTES[@]}"

      # --------------------------------------
      # Real Time: Get the smallest minute and
      #   create a new array for servers.
      # --------------------------------------
      SMALLEST=9999

      for MINUTE in "${MINUTES[@]}"
      do
        IS_SMALLER=$(echo "${MINUTE} < ${SMALLEST}" | bc)
        if [ ${IS_SMALLER} -eq 1 ]
          then
            SMALLEST="${MINUTE}"
          fi
      done
      echo "SMALLEST:  ${SMALLEST}"

      INDEX=0
      NEW_SERVERS=()
      NEW_TIMER=()

      for MINUTE in "${MINUTES[@]}"
      do
        if [[ "${MINUTE}" == "${SMALLEST}" ]]
          then
            SMALLEST="${MINUTE}"
            NEW_SERVERS[${INDEX}]="${SERVERS[${INDEX}]}"
            NEW_TIMER[${INDEX}]="${TIMER[${INDEX}]}"
          fi
          INDEX=$(( INDEX + 1 ))
      done
      SERVERS=("${NEW_SERVERS[@]}")
      TIMER=("${NEW_TIMER[@]}")
      echo "TIMER:     ${TIMER[@]}"
      echo""
      echo""

      # --------------------------------------
      # Real Time: Extract the real time
      #   separate by seconds.
      # --------------------------------------
      INDEX=0
      SECONDS=()

      echo "# Get seconds:"
      echo ""
      for TIME in "${TIMER[@]}"
      do
        echo "$TIME"
        SECONDS[${INDEX}]=$(echo "$TIME" | sed -E "s/.*m([0-9]*)\..*/\1/")
        INDEX=$(( INDEX + 1 ))
      done
      echo ""
      echo "SECONDS:   ${SECONDS[@]}"

      # --------------------------------------
      # Real Time: Get the smallest second and
      #   create a new array for servers.
      # --------------------------------------
      SMALLEST=9999

      for SECOND in "${SECONDS[@]}"
      do
        IS_SMALLER=$(echo "${SECOND} < ${SMALLEST}" | bc)
        if [ ${IS_SMALLER} -eq 1 ]
          then
            SMALLEST="${SECOND}"
          fi
      done
      echo "SMALLEST:  ${SMALLEST}"

      INDEX=0
      NEW_SERVERS=()
      NEW_TIMER=()

      for SECOND in "${SECONDS[@]}"
      do
        if [[ "${SECOND}" == "${SMALLEST}" ]]
          then
            SMALLEST="${SECOND}"
            NEW_SERVERS[${INDEX}]="${SERVERS[${INDEX}]}"
            NEW_TIMER[${INDEX}]="${TIMER[${INDEX}]}"
          fi
          INDEX=$(( INDEX + 1 ))
      done
      SERVERS=("${NEW_SERVERS[@]}")
      TIMER=("${NEW_TIMER[@]}")
      echo "TIMER:     ${TIMER[@]}"
      echo""
      echo""

      # --------------------------------------
      # Real Time: Extract the real time
      #   separate by milliseconds.
      # --------------------------------------
      INDEX=0
      MILLISECONDS=()

      echo "# Get milliseconds:"
      echo ""
      for TIME in "${TIMER[@]}"
      do
        echo "$TIME"
        MILLISECONDS[${INDEX}]=$(echo "$TIME" | sed -E "s/.*\.([0-9]*)s/\1/")
        INDEX=$(( INDEX + 1 ))
      done
      echo ""
      echo "MILLISECONDS: ${MILLISECONDS[@]}"

      # --------------------------------------
      # Real Time: Get the smallest milliseconds
      #   and create a new array for servers.
      # --------------------------------------
      SMALLEST=9999

      for MILLISECOND in "${MILLISECONDS[@]}"
      do
        IS_SMALLER=$(echo "${MILLISECOND} < ${SMALLEST}" | bc)
        if [ ${IS_SMALLER} -eq 1 ]
          then
            SMALLEST="${MILLISECOND}"
          fi
      done
      echo "SMALLEST:  ${SMALLEST}"

      INDEX=0
      NEW_SERVERS=()
      NEW_TIMER=()

      for MILLISECOND in "${MILLISECONDS[@]}"
      do
        if [[ "${MILLISECOND}" == "${SMALLEST}" ]]
          then
            SMALLEST="${MILLISECOND}"
            NEW_SERVERS[${INDEX}]="${SERVERS[${INDEX}]}"
            NEW_TIMER[${INDEX}]="${TIMER[${INDEX}]}"
          fi
          INDEX=$(( INDEX + 1 ))
      done
      SERVERS=("${NEW_SERVERS[@]}")
      TIMER=("${NEW_TIMER[@]}")
      echo "TIMER:     ${TIMER[@]}"
      echo""
      echo""

      # --------------------------------------
      # Save the best servers in the mirror file.
      # --------------------------------------
      echo "" > "${FILE}"
      for SERVER in "${SERVERS[@]}"
      do
        echo "${SERVER}" >> "${FILE}"
      done
      echo "SERVERS:   ${SERVERS[@]}"
      echo""

      # --------------------------------------
      # Upgrade the packages.
      # --------------------------------------
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

echo ""
echo -e "~~~~~~~~~~~ FINISHED THE SERVICE TO RUN REFLECTOR ~~~~~~~~~~~"
