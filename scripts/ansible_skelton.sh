#!/bin/sh
USAGE="$0 <playbook name>"

main() {
    if [ $# -lt 1 ] ; then
        echo $USAGE
        exit 1
    fi

    # mkdir

    pb_name=$1

    mkdir -p ${pb_name}/{group_vars,host_vars,hosts}
    mkdir -p ${pb_name}/roles/common/{tasks,handlers,templates,files,vars,defaults,meta}
    touch ${pb_name}/roles/common/{tasks,handlers,templates,vars,defaults,meta}/main.yml
    touch ${pb_name}/hosts/{production,staging,developments}
    touch ${pb_name}/site.yml
}

main $@
