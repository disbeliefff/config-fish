function kubectx
    set -l prev_ctx (kubectl config current-context 2>/dev/null)

    command kubectx $argv
    if test $status -ne 0
        return 1
    end

    set -l new_ctx (kubectl config current-context)
    
    if test "$prev_ctx" = "$new_ctx"
        return 0
    end

    set_color green
    echo "Current context: $new_ctx"
    set_color normal

    kubectl cluster-info --request-timeout=2s >/dev/null 2>&1
    if test $status -eq 0
        echo "Cluster: "(kubectl config view --minify -o jsonpath='{.clusters[].name}')
        echo "Namespace: "(kubectl config view --minify -o jsonpath='{.contexts[].context.namespace}')
    else
        set_color red
        echo "⚠ Cluster unreachable"
        set_color normal
    end
end