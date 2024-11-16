#!/usr/bin/env zsh

# Function to get available languages from cht.sh
function get_languages() {
    curl -s "cht.sh/:list" | grep -v '^/' | grep -v '^$' | sort -u
}

# Function to get queries for a specific language
function get_queries() {
    local lang=$1
    # Add quotes around the language name to handle spaces
    curl -s "cht.sh/${lang}/:list" | grep -v '^$' | sed 's/\+/ /g' | sort -u
}

# Function to get answer from cht.sh
function get_answer() {
    local lang=$1
    local query=$2
    # URL encode the query
    local encoded_query=$(echo "$query" | sed 's/ /+/g')
    curl -s "cht.sh/$lang/$encoded_query" | less -R
}

# Get language selection using fzf
selected_language=$(get_languages | /opt/homebrew/bin/fzf --height=50% --prompt="Select language > ")

if [[ -z $selected_language ]]; then
    print "No language selected. Exiting."
    exit 1
fi

# Get query selection using fzf
# Add quotes around the language to handle spaces
selected_query=$(get_queries "${selected_language}" | /opt/homebrew/bin/fzf --height=50% --preview "curl -s 'cht.sh/${selected_language}/{}'" --preview-window=right:70% --prompt="Select query > ")

# if [[ -z $selected_query ]]; then
#     print "No query selected. Exiting."
#     exit 1
# fi

# Get and display the answer
get_answer "$selected_language" "$selected_query"
