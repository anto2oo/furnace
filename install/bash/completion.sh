_all_modules()
{
    find /usr/local/bin/ -name "furnace-*" | awk -F - '{print $2}' | sort | uniq
}

_module_actions()
{
    find /usr/local/bin/ -name "furnace-${1}-*" | awk -F - '{print $3}' | sort | uniq
}

_action_params()
{
    furnace "$1" "$2" -o
}

_furnace_comp()
{
        cur=${COMP_WORDS[COMP_CWORD]}
        prev=${COMP_WORDS[COMP_CWORD-1]}
        COMPREPLY=()
        if [[ "${#COMP_WORDS[@]}" == "2" ]] ; then
                options=$(_all_modules)
        elif [[ "${#COMP_WORDS[@]}" == "3" ]]; then
            if [[ "${COMP_WORDS[3]}" ]]; then
                echo "${COMP_WORDS[3]}"
            fi
                options=$(_module_actions "$prev")
        else
            compopt -o nospace
            options=$(_action_params "${COMP_WORDS[1]}" "${COMP_WORDS[2]}")
        fi

        COMPREPLY=( $( compgen -W "$options" -- ${cur} ) )
}

complete -F _furnace_comp furnace

