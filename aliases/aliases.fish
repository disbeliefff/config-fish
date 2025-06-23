alias k="kubectl"
alias kgp="kubectl get pods"
alias kgpa="kubectl get pods -n apps"
alias kgpm="kubectl get pods -n monitoring"
alias kl="kubectl logs -f"

alias kctx="kubectx"
alias kns="kubens"

alias kcurrent="kubectl config current-context"

alias kdev="kubectx dev"
alias kprod="kubectx prod"
alias kstg="kubectx staging"

alias d="docker"
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}'"
alias dimg="docker images --format 'table {{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}'"


alias f="flux"
alias fga="flux get all -A"
alias frka="flux reconcile kustomization apps --with-source"
alias frik="flux reconcile kustomization infrastructure --with-source"