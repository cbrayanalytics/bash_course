#!/usr/bin/env bash

# =================================================
#  Validation functions
# =================================================

# Check minimum requirements
validate_arguments() {
  if [ "$#" -lt 1 ]; then
    cat <<EOF
Error: At least one argument is required
Usage: ./process_all.sh <arg1> [arg2] [arg3] ...
EOF
    exit 1
  fi
}

# =================================================
#  Main functions
# =================================================
main() {
  validate_arguments "$@"
}

# Execute main function
main "$@"
