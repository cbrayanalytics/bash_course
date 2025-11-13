#!/usr/bin/env bash
set -euo pipefail

#================================================================
# Script: Prompts user for a password and returns via stdout.
# Author: Casey Bray
# Last Modified: 2025-11-06
#================================================================


#================================================================
# Logic functions
#================================================================

# Verify password is not empty
# If empty, error message is printed and exit code of "1"
# is returned
empty_validate() {
  if [[ -z "${first_passwd}" ]]; then
    local empty_msg="✗ Error: Password must not be empty"
    echo "${empty_msg}"
    exit 1
  fi
}

# Verify password is at least 7 characters in length
# If not, error message is printed and exit code of "2"
# is returned
length_validate() {
  local password_length="${#first_passwd}"

  if [[ "${password_length}" -lt 7 ]]; then
    local length_msg="✗ Error: Password must be at least 7 characters in length"
    echo "${length_msg}"
    exit 2
  fi
}

# Verify password contains at least two numbers.
# If not, error message is printed and exit code of "3"
# is returned
number_validate() {
  if ! [[ "$first_passwd" =~ [0-9]{2}$ ]]; then
    local number_msg="✗ Error: Password must contain at least two numbers"
    echo "${number_msg}"
    exit 3
  fi
}
  
# Prompt user for password. 
# * Check if password is empty and return error message 
# and exit code of "1" if so.
# * Check if password contains at least 7 characters
# and return error message and exit code of "2" if not
# * Check if password contains at least two numbers
# and return error message and exit code of "3" if not
get_password() {
  read -sp "Enter password: " first_passwd
  echo

  # Check if string received
  empty_validate

  # Check if length is met
  length_validate

  # Check if at least two numbers are present
  number_validate

}

# Prompt user again for password
# If passwords match, display succeess else
# if passwords do not match, display fail 
# message and return exit code of "2"
confirm_password() {
  read -sp "Confirm password: " second_password
  echo

  if [[ "${first_passwd}" == "${second_password}" ]]; then
    local success_msg="✓ Passwords match!"
    echo "${success_msg}"
  else
    local fail_msg="✗ Error: Passwords do not match!"
    echo "${fail_msg}"
    exit 2
  fi
}


# Get password length and print to stdout
display_length() {
  password_length="${#first_passwd}"
  
  echo "Password length: ${password_length} characters"
}


#================================================================
# Main function
#================================================================
main() {
  # Prompt user for password
  get_password

  # Confirm user password
  confirm_password

  # Return password to stdout
  display_length
}

main "$@"
