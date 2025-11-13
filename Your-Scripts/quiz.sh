 #!/usr/bin/env bash

#================================================================
# Script: quiz.sh
# Description: Brief description of what this script does
# Author: Casey Bray
# Date: 2025-11-08
#================================================================

# Script variables
readonly SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
readonly SCRIPT_NAME="$(basename "${0}")"
readonly TIME_LIMIT=5


#----------------------------------------------------------------
# Logic functions
#----------------------------------------------------------------
question() {
    read -t "${TIME_LIMIT}" -p "Quick! What is 5 + 7? (${TIME_LIMIT} seconds): " answer
    local status=$?

    if [ "${status}" -ne 0 ]; then
        local timeout_msg="Time's up! You didn't answer in time."
        echo "\n${timeout_msg}"
    elif [ "${status}" -eq 0 ] && [ "${answer}" -eq 12 ]; then
        local success_msg="Correct! You answered in time."
        echo "${success_msg}"
    else
        local fail_msg="Wrong answer! The correct answer is 12."
        echo "${fail_msg}"
    fi
}



#----------------------------------------------------------------
# Main function
#----------------------------------------------------------------
main() {
    # Prompt user for question
    question
}

# Execute main function
main "$@" 
