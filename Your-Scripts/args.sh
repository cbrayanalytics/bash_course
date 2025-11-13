#!/usr/bin/env bash

## Get the count of arguments
COUNT="$#"

# ===============================================
#  Validation Functions
# ===============================================
validate_min_args() {
  if [[ "${COUNT}" -lt 2 ]]; then
    cat <<EOF
✗ Error: Not enough arguments
Usage: ./validate_args.sh <arg1> <arg2> [arg3] [arg4] [arg5]
Requires: 2-5 arguments
Received: ${COUNT} arguments 
EOF
    exit 1
  fi
}

validate_max_args() {
  if [[ "${COUNT}" -gt 5 ]]; then
    cat <<EOF
✗ Error: Too many arguments
Usage: ./validate_args.sh <arg1> <arg2> [arg3] [arg4] [arg5]
Requires: 2-5 arguments
Received: ${COUNT} arguments 
EOF
    exit 1
  fi
}

validation_passed() {
  cat <<EOF
  ✓ Valid number of arguments

EOF
}

display_argument_count() {
  cat <<EOF
  Arguments received: ${COUNT}
EOF
}

display_first_argument() {
  local first_arg="$1"
  cat <<EOF
  First argument: ${first_arg}
EOF
}

display_last_argument() {
  local last_arg="${!#}"
  cat <<EOF
  Last argument: ${last_arg}
EOF
}

display_all_arguments() {
  local all_args="$*"
  cat <<EOF
  All arguments: ${all_args}
EOF
}

# ===============================================
#  Logic Functions
# ===============================================
even_or_odd() {
  local remainder=$((COUNT % 2))

  if [ ${remainder} -eq 0 ]; then
    echo "Even number of arguments detected - pairing them:"

    local index=1
    local pair_num=2

    while [ ${index} -le ${COUNT} ]; do
      local arg1="${!index}"

      # local arg2_index=$((pair_num + 1))
      local arg2="${!pair_num}"

      cat <<EOF
Pair $pair_num: $arg1 <-> $arg2
EOF
      ((index += 2))
      ((pair_num += 2))
    done
  else
    local middle_arg_index=$(((COUNT + 1) / 2))
    echo "Middle arg: $middle_arg_index"
    local middle_arg=${!middle_arg_index}
    cat <<EOF
Odd number of arguments detected
Middle argument: $middle_arg
EOF
  fi
}

# ===============================================
#  Main Function
# ===============================================
main() {
  if validate_min_args "$@" && validate_max_args "$@"; then
    validation_passed
    display_argument_count "$@"
    display_first_argument "$@"
    display_last_argument "$@"
    display_all_arguments "$@"
    even_or_odd "$@"
  fi
}

# Execute main function
main "$@"
