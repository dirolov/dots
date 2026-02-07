set -g fish_prompt_pwd_dir_length 1

function fish_prompt
    set -l last_status $status
    set -l pwd (prompt_pwd)

    set -l git_info ''
    set -l git_branch (fish_git_branch_name)
    if test -n "$git_branch"
        set -l git_status_flags (fish_git_status_flags)
        set git_info " ($git_branch$git_status_flags)"
    end

    set -l prompt_char '$'
    if test $EUID -eq 0
        set prompt_char '#'
    end

    set -l bg_jobs_info ''
    set -l job_count (count (jobs -p))
    if test $job_count -gt 0
        set bg_jobs_info " %$job_count"
    end

    printf '%s%s%s' $pwd $git_info $bg_jobs_info

    if test $last_status -ne 0
        printf ' [%s]' $last_status
    end

    printf ' %s ' $prompt_char
end

function fish_git_branch_name
    command git symbolic-ref --short HEAD 2>/dev/null
    or command git rev-parse --short HEAD 2>/dev/null
end

function fish_git_status_flags
    set -l flags ''
    set -l git_dir (command git rev-parse --git-dir 2>/dev/null)

    if test -n "$git_dir"
        if not command git diff --quiet --ignore-submodules HEAD 2>/dev/null
            set flags $flags '*'
        end

        if not command git diff --cached --quiet --ignore-submodules HEAD 2>/dev/null
            set flags $flags '~'
        end

        if command git --no-optional-locks status --porcelain --untracked-files=no 2>/dev/null | command grep -q '^.[^ ?]'
            set flags $flags '…'
        end

        if test -f "$git_dir/refs/stash"
            set flags $flags '$'
        end

        if command git config --get-regexp 'remote\..*\.push' 1>/dev/null 2>&1
            set -l upstream (command git rev-parse --abbrev-ref --symbolic-full-name @{upstream} 2>/dev/null)
            if test -n "$upstream"
                set -l abbrev_upstream (command git rev-parse --abbrev-ref $upstream 2>/dev/null)
                if test -n "$abbrev_upstream"
                    set -l count (command git rev-list --left-right --count HEAD...$upstream 2>/dev/null)
                    if test -n "$count"
                        set -l left (echo $count | cut -f1)
                        set -l right (echo $count | cut -f2)
                        if test $left -gt 0; and test $right -gt 0
                            set flags $flags '±'
                        else if test $left -gt 0
                            set flags $flags '+'
                        else if test $right -gt 0
                            set flags $flags '-'
                        end
                    end
                end
            end
        end
    end
    echo $flags
end