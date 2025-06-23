function __safe_kubectx_list
    if command -q kubectx
        kubectx --quiet 2>/dev/null || kubectx -q 2>/dev/null || kubectx 2>/dev/null | awk '{print $1}'
    else
        kubectl config get-contexts -o name 2>/dev/null
    end | sort -u
end

function __safe_kubens_list
    if command -q kubens
        kubens --quiet 2>/dev/null || kubens -q 2>/dev/null || kubens 2>/dev/null | awk '{print $1}'
    else
        kubectl get namespaces -o jsonpath='{.items[*].metadata.name}' 2>/dev/null
    end | sort -u
end

function __cached_kubectx_list
    set -l cache_file /tmp/fish_kubectx_cache
    set -l need_refresh 1
    
    if test -f $cache_file
        # Получаем текущее время и время модификации файла
        set -l now (date +%s)
        set -l mtime (stat -c %Y $cache_file 2>/dev/null || echo 0)
        
        # Проверяем, не устарел ли кэш
        set -l age (math "$now - $mtime")
        if test $age -le 300
            set need_refresh 0
        end
    end
    
    if test $need_refresh -eq 1
        __safe_kubectx_list > $cache_file
    end
    
    cat $cache_file
end

function __cached_kubens_list
    set -l cache_file /tmp/fish_kubens_cache
    set -l need_refresh 1
    
    if test -f $cache_file
        set -l now (date +%s)
        set -l mtime (stat -c %Y $cache_file 2>/dev/null || echo 0)
        
        set -l age (math "$now - $mtime")
        if test $age -le 300
            set need_refresh 0
        end
    end
    
    if test $need_refresh -eq 1
        __safe_kubens_list > $cache_file
    end
    
    cat $cache_file
end

complete -c kctxn -f
complete -c kctxn -n 'not __fish_seen_subcommand_from (__cached_kubectx_list)' \
    -a '(__cached_kubectx_list)' \
    -d 'Kubernetes context'

complete -c kctxn -n '__fish_seen_subcommand_from (__cached_kubectx_list)' \
    -a '(__cached_kubens_list)' \
    -d 'Kubernetes namespace'