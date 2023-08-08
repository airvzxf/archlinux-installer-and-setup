#!/usr/bin/env bash
set +xve

MONITOR="DP-0"
MATH_SIGN="+"
DISPLAY_INFORMATION=FALSE
BRIGHTNESS_LIMIT="100"
BRIGHTNESS=""

parse_arguments() {
  while [[ ${#} -gt 0 ]]; do
    case "${1}" in
    -c | --current)
      # Remove this argument.
      shift
      DISPLAY_INFORMATION=true
      ;;
    -d | --decrease)
      # Remove this argument.
      shift
      MATH_SIGN="-"
      BRIGHTNESS="${1//[-+]/}"
      # Remove this value.
      shift
      ;;
    -h | --help)
      display_help
      ;;
    -i | --increase)
      # Remove this argument.
      shift
      MATH_SIGN="+"
      BRIGHTNESS="${1//[-+]/}"
      # Remove this value.
      shift
      ;;
    -l | --limit)
      # Remove this argument.
      shift
      BRIGHTNESS_LIMIT="${1}"
      # Remove this value.
      shift
      ;;
    -m | --monitor)
      # Remove this argument.
      shift
      MONITOR="${1}"
      # Remove this value.
      shift
      ;;
    --* | -*)
      echo "Unknown option ${1}."
      echo "Review the help with this command:"
      echo "  brightness-xrandr -h"
      exit 1
      ;;
    *)
      # Any argument without an option.
      echo "Unknown option ${1}."
      echo "Review the help with this command:"
      echo "  brightness-xrandr -h"
      exit 1
      ;;
    esac
  done
}

display_help() {
  echo "brightness-xrandr v2023.08.01.01"
  echo ""
  echo "USAGE:"
  echo "  brightness-xrandr [OPTIONS]"
  echo ""
  echo "DESCRIPTION"
  echo "  It changes the brightness using the command 'xrandr'."
  echo "  Executing the command: 'xrandr --output MONITOR --brightness NEW_BRIGHTNESS'."
  echo ""
  echo "  NEW_BRIGHTNESS:"
  echo "    This value is calculated using the following formula: the current brightness"
  echo "    value [plus or minus] the value obtained from the BRIGHTNESS option."
  echo ""
  echo "ARGS:"
  echo "  NONE."
  echo ""
  echo "OPTIONS:"
  echo "  ┌──────┬──────────────────┬──────────────────────────────────────────────────┐"
  echo "  │ Abbr │       Long       │                     Information                  │"
  echo "  ╞══════╪══════════════════╪══════════════════════════════════════════════════╡"
  echo "  │  -c  │ --current        │ Shows the current information: selected monitor  │"
  echo "  │      │                  │ and brightness. This option is only compatible   │"
  echo "  │      │                  │ with the option '--monitor'.                     │"
  echo "  │      │                  │   - Required: no                                 │"
  echo "  │      │                  │   - Type:     none                               │"
  echo "  │      │                  │   - Values:   none                               │"
  echo "  │      │                  │   - Default:  none                               │"
  echo "  ├──────┼──────────────────┼──────────────────────────────────────────────────┤"
  echo "  │  -d  │ --decrease       │ Decrease the brightness.                         │"
  echo "  │      │                  │   - Required: yes | Do not select increment.     │"
  echo "  │      │                  │   - Type:     unsigned integer                   │"
  echo "  │      │                  │   - Values:   0 - 100                            │"
  echo "  │      │                  │   - Default:  none                               │"
  echo "  ├──────┼──────────────────┼──────────────────────────────────────────────────┤"
  echo "  │  -h  │ --help           │ Display information for this command and exit.   │"
  echo "  │      │                  │   - Required: no                                 │"
  echo "  │      │                  │   - Type:     none                               │"
  echo "  │      │                  │   - Values:   none                               │"
  echo "  │      │                  │   - Default:  none                               │"
  echo "  ├──────┼──────────────────┼──────────────────────────────────────────────────┤"
  echo "  │  -i  │ --increase       │ Increase the brightness.                         │"
  echo "  │      │                  │   - Required: yes | Do not select decrease.      │"
  echo "  │      │                  │   - Type:     unsigned integer                   │"
  echo "  │      │                  │   - Values:   0 - 100                            │"
  echo "  │      │                  │   - Default:  none                               │"
  echo "  ├──────┼──────────────────┼──────────────────────────────────────────────────┤"
  echo "  │  -l  │ --limit          │ Set the limit of the brightness.                 │"
  echo "  │      │                  │   - Required: no                                 │"
  echo "  │      │                  │   - Type:     unsigned integer                   │"
  echo "  │      │                  │   - Values:   0 - 100000, infinite               │"
  echo "  │      │                  │   - Default:  100                                │"
  echo "  ├──────┼──────────────────┼──────────────────────────────────────────────────┤"
  echo "  │  -m  │ --monitor        │ Sets the name of the monitor, which will change  │"
  echo "  │      │                  │ the brightness.                                  │"
  echo "  │      │                  │ It can get the name of the monitor with the      │"
  echo "  │      │                  │ 'xrandr' command.                                │"
  echo "  │      │                  │   - Required: no                                 │"
  echo "  │      │                  │   - Type:     string                             │"
  echo "  │      │                  │   - Values:   HDMI-0                             │"
  echo "  │      │                  │   - Default:  DP-3                               │"
  echo "  └──────┴──────────────────┴──────────────────────────────────────────────────┘"
  echo ""
  echo ""
  echo "EXAMPLES:"
  echo "  - Using the default monitor, increase the brightness."
  echo "    - Commands:"
  echo "        brightness-xrandr --increase 3"
  echo ""
  echo "  - Using the default monitor, decrease the brightness."
  echo "    - Commands:"
  echo "        brightness-xrandr --decrease 7"
  echo ""
  echo "- Monitor settings and brightness increase."
  echo "    - Commands:"
  echo "        brightness-xrandr --monitor HDMI-0 --increase 3"
  echo ""
  echo "- Increases the maximum brightness value to 150. Which is equal to 1.5 when"
  echo "  using the 'xrandr' command."
  echo "    - In this example, the current brightness value is 95; this will increase"
  echo "      the brightness value to 110 or 1.10 in 'xrandr'. If the limit was 100,"
  echo "      this would have set the brightness to 100 (1.0) instead of 110 (1.10)."
  echo "        brightness-xrandr --limit 150 --increase 15"
  echo ""
  echo "- Get the current brightness of a specific monitor."
  echo "    - Commands:"
  echo "        brightness-xrandr --current"
  echo "        brightness-xrandr --current --monitor HDMI-0"
  echo "        brightness-xrandr --current --monitor DP-0"
  echo ""
  echo "  - Multiple options can be used multiple times. It will only take the last"
  echo "    value of each option."
  echo "    - In this example it will decrease the brightness by 10."
  echo "        brightness-xrandr \\"
  echo "          --increase 80 \\"
  echo "          --decrease 20 \\"
  echo "          --increase 70 \\"
  echo "          --decrease 10"
  echo ""
  echo ""
  exit 0
}

main() {
  parse_arguments "${@}"

  echo "MONITOR: ${MONITOR}"

  # Check brightness
  xrandr --verbose --current |
    grep --after-context 5 ^"${MONITOR}" |
    tail --lines 1 |
    grep --ignore-case --quiet "Brightness" || {
    echo "ERROR: This monitor (${MONITOR}) does not contain the brightness property."
    echo "Review the help: brightness-xrandr --help"
    exit 0
  }

  # Get brightness
  local XRANDR_BRIGHTNESS
  XRANDR_BRIGHTNESS=$(
    xrandr --verbose --current |
      grep --after-context 5 ^"${MONITOR}" |
      tail --lines 1 |
      sed "s/\s*Brightness:\s*//"
  )
  echo "XRANDR_BRIGHTNESS: ${XRANDR_BRIGHTNESS}"

  if [[ "${DISPLAY_INFORMATION}" = true ]]; then
    exit 0
  fi

  local BRIGHTNESS_LIMIT_XRANDR
  BRIGHTNESS_LIMIT_XRANDR=$(echo "${BRIGHTNESS_LIMIT} * 0.01" | bc)
  echo "BRIGHTNESS_LIMIT: ${BRIGHTNESS_LIMIT}"
  echo "BRIGHTNESS_LIMIT_XRANDR: ${BRIGHTNESS_LIMIT_XRANDR}"

  if [[ "${MATH_SIGN}" = "+" ]]; then
    echo "Increase the brightness."
  else
    echo "Decrease the brightness."
  fi

  echo "MATH_SIGN: ${MATH_SIGN}"
  echo "BRIGHTNESS: ${BRIGHTNESS}"

  local BRIGHTNESS_MODIFIER
  BRIGHTNESS_MODIFIER=$(echo "${BRIGHTNESS} * 0.01" | bc)
  echo "BRIGHTNESS_MODIFIER: ${BRIGHTNESS_MODIFIER}"

  local BRIGHTNESS_NEW
  BRIGHTNESS_NEW=$(echo "${XRANDR_BRIGHTNESS} ${MATH_SIGN} ${BRIGHTNESS_MODIFIER}" | bc)
  echo "BRIGHTNESS_NEW: ${BRIGHTNESS_NEW}"

  if [[ $(echo "${BRIGHTNESS_NEW} > ${BRIGHTNESS_LIMIT_XRANDR}" | bc) = "1" ]]; then
    echo "Set the brightness to maximum (xrandr value to ${BRIGHTNESS_LIMIT_XRANDR})."
    BRIGHTNESS_NEW="${BRIGHTNESS_LIMIT_XRANDR}"
    echo "BRIGHTNESS_NEW: ${BRIGHTNESS_NEW}"
  fi

  if [[ $(echo "${BRIGHTNESS_NEW} < 0" | bc) = "1" ]]; then
      echo "Set the brightness to minimum (xrandr value to 0)."
      BRIGHTNESS_NEW="0"
      echo "BRIGHTNESS_NEW: ${BRIGHTNESS_NEW}"
  fi

  xrandr --output "${MONITOR}" --brightness "${BRIGHTNESS_NEW}"

  # Validate brightness
  XRANDR_BRIGHTNESS=$(
    xrandr --verbose --current |
      grep --after-context 5 ^"${MONITOR}" |
      tail --lines 1 |
      sed "s/\s*Brightness:\s*//"
  )
  echo "XRANDR_BRIGHTNESS: ${XRANDR_BRIGHTNESS}"
}

main "${@}"
