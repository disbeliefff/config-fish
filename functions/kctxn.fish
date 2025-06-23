function kctxn
    set -l lock_file ~/.kube/config.lock
    if test -f $lock_file
        set -l lock_pid (cat $lock_file 2>/dev/null)
        if not ps -p $lock_pid >/dev/null 2>&1
            rm -f $lock_file
        end
    end
    
    kubectl config use-context $argv[1] >/dev/null
    and kubectl config set-context --current --namespace=$argv[2] >/dev/null
    
    if test $status -ne 0
        set_color red
        echo "Switch failed! Lock file may still exist."
        set_color normal
        return 1
    end
    
    set -l current_ctx (kubectl config current-context 2>/dev/null)
    set -l current_ns (kubectl config view --minify -o jsonpath='{.contexts[0].context.namespace}' 2>/dev/null)
    
    set_color green
    echo "Switched to $argv[1]:$argv[2]"
    set_color normal
end