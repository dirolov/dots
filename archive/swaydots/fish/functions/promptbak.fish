set -g fish_prompt_pwd_dir_length 1

function fish_prompt
    set -l last_status $status

    # --- Цвета ---
    set -l color_path blue
    set -l color_exit_code red

    # --- Текущая директория ---
    set -l pwd (prompt_pwd)

    # --- Git ---
    set -l git_info ''
    set -l git_branch (fish_git_branch_name)
    if test -n "$git_branch"
        set -l git_status_flags (fish_git_status_flags)
        set git_info " ($git_branch$git_status_flags)"
    end

    # --- Символ команды ---
    set -l prompt_char '$'
    if test $EUID -eq 0
        set prompt_char '#'
    end

    # --- Фоновые задачи ---
    set -l bg_jobs_info ''
    set -l job_count (count (jobs -p))
    if test $job_count -gt 0
        set bg_jobs_info " %$job_count"
    end

    # --- Вывод основной строки ---
    # Выводим директорию с цветом
    set_color $color_path
    printf '%s' $pwd
    set_color normal
    # Всё остальное без цвета
    printf '%s%s' $git_info $bg_jobs_info

    # --- Код выхода (красный, если не 0) ---
    if test $last_status -ne 0
        set_color $color_exit_code --bold
        printf ' [%s]' $last_status
        set_color normal
    end

    # --- Символ команды ---
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
