#!/usr/bin/env bash
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    ${SCRIPT_NAME} [OPTIONS] [ARGUMENTS]
#%
#% DESCRIPTION
#%    This script prompts the user for name, age, and location.
#%    Then, returns formatted input to stdout for viewing.
#%
#% OPTIONS
#%    -h, --help                    Print this help message
#%
#% EXAMPLES
#%    ${SCRIPT_NAME} --input data.txt --output result.txt
#%
#================================================================



#================================================================
# GLOBAL VARIABLES
#================================================================


# Script metadata
readonly SCRIPT_NAME="$(basename "${0}")"
readonly SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
readonly SCRIPT_VERSION="1.0.0"
readonly SCRIPT_AUTHOR="Casey Bray"


# VARIABLES
readonly EMPTY_LINE=""



#================================================================
# LOGIC FUNCTIONS
#================================================================


#----------------------------------------------------------------
# Prompt user for full name 
# If user name is empty, return an error
#
# Arguments:
#
# Returns:
#   None if valid input, 1 otherwise
#----------------------------------------------------------------
get_name() {
  read -p "Please enter your full name: " first_name last_name

  if [[ -z "$first_name" ]]; then
    local name_error="ERROR: Name cannot be empty"
    echo "${name_error}"
    exit 1
  fi
}


#----------------------------------------------------------------
# Prompt user for age 
# If age is not a number, return an error
#
# Arguments:
#
# Returns:
#   None if valid input and age is number, 1 otherwise
#----------------------------------------------------------------
get_age(){
  read -p "Please enter your age: " age

  if ! [[ "$age" =~ ^[0-9]+$ ]]; then
    local age_error="Error: Age must be a number(Example: 19)"
    echo "${age_error}"
    exit 1
  fi
}


#----------------------------------------------------------------
# Prompt user for location 
# If location is empty, return an error
#
# Arguments:
#
# Returns:
#   None if valid input, 1 otherwise
#----------------------------------------------------------------
get_location() {
  read -p "Please enter your location(<city>, <state>): " location

  if [[ -z "$location" ]]; then
    local location_error="ERROR: location cannot be empty"
    echo "${location_error}"
    exit 1
  fi
}


#----------------------------------------------------------------
# Print user input formatted 
#
# Arguments:
#
# Returns:
#   none
#----------------------------------------------------------------
print_info() {
  # profile header
  local header="=== User Profile ==="

  # print information
  echo "${EMPTY_LINE}"
  echo "${header}"
  echo "Name: ${first_name} ${last_name}"
  echo "age: ${age}"
  echo "Name: ${location}"
}



#================================================================
# MAIN EXECUTION
#================================================================


#----------------------------------------------------------------
# Main function - entry point of the script
#
# Arguments:
#   $@ - All command-line arguments
# Returns:
#   0 on success, non-zero on failure
#----------------------------------------------------------------
main() {
  # Get user full name 
  get_name

  # Get user age
  get_age
 
  # Get user location
  get_location

  # Return user information to stdout
  print_info

  exit 0
}

# Execute main function
main

