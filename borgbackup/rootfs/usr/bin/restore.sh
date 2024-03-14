


# Backup a remote host locally ("pull" style) using sshfs
#$ mkdir sshfs-mount
#$ sshfs root@example.com:/ sshfs-mount
#$ cd sshfs-mount
#$ borg create /path/to/repo::example.com-root-{now:%Y-%m-%d} .
#$ cd ..
#$ fusermount -u sshfs-mount

#!/usr/bin/env bashio
set +u

export BORG_BASE_DIR=/config/borg
export BORG_CACHE_DIR=${BORG_BASE_DIR}/cache
export BORG_REPO=""
export BACKUP_TIME=$(date  +'%Y-%m-%d-%H:%M')

export _BORG_PATH=$(bashio::config 'borg_path')
export _BORG_USER=$(bashio::config 'borg_user')
export _BORG_HOST=$(bashio::config 'borg_host')
export _BORG_PORT=$(bashio::config 'borg_port')
export _BORG_REPONAME=$(bashio::config 'borg_reponame')
export _BORG_ENCRYPTION=$(bashio::config 'borg_encryption')
export _BORG_REPO_URL=$(bashio::config 'borg_repo_url')
export BORG_PASSPHRASE=$(bashio::config 'borg_passphrase')
export _BORG_ARCHIVE=$(bashio::config 'borg_archive')
export _BORG_SSH_PARAMS=$(bashio::config 'borg_ssh_params')
export _BORG_SSH_ENCRYTION=$(bashio::config 'borg_ssh_encryption')
export _BORG_COMPRESSION=$(bashio::config 'borg_compression')
export _BORG_PRUNE_OPTIONS=$(bashio::config 'borg_prune_options')

export _BORG_SSH_KNOWN_HOSTS=${BORG_BASE_DIR}/known_hosts
export _BORG_SSH_KEY=${BORG_BASE_DIR}/keys/borg_backup

export _BORG_BACKUP_DEBUG="$(bashio::config 'borg_backup_debug')"
export _BORG_DEBUG=''
export borg_error=0

export BORG_RSH="ssh -o UserKnownHostsFile=${_BORG_SSH_KNOWN_HOSTS} -i ${_BORG_SSH_KEY} ${_BORG_SSH_PARAMS}"

mkdir -p $(dirname ${_BORG_SSH_KEY}) ${BORG_CACHE_DIR}

##### passwords crap
if [ ${#BORG_PASSPHRASE} -eq 0 ];then
    export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK=yes
    unset BORG_PASSPHRASE
fi
# set zstd as default compression
if [ ${#_BORG_COMPRESSION} -eq 0 ];then
    _BORG_COMPRESSION="zstd"
fi

if [ ${#BORG_BACKUP_DEBUG} -ne 0 ];then
    _BORG_DEBUG="--debug"
fi

function sanity_checks {
    if [[ ( ${#_BORG_REPO_URL} -eq 0 ) && ( ${#_BORG_HOST} -eq 0 )]];then
        bashio::log.error "both 'borg_repo_url' 'borg_host' undefined"
        bashio::log.error "please define one of them"
        borg_error=$(($borg_error + 1))
    elif [[ ( ${#_BORG_REPO_URL} -gt 0 ) && ( ${#_BORG_HOST} -gt 0 )]];then
        bashio::log.error "'borg_repo_url' and 'borg_host' are definded"
        bashio::log.error "please define only one of them"
        borg_error=$(($borg_error + 1))
    else
        bashio::log.info "sanity preserved"
    fi
}

function set_borg_repo_path {
    bashio::log.debug "Setting BORG_REPO"
    if [ ${#_BORG_REPO_URL} -gt 0 ]; then
        BORG_REPO=${_BORG_REPO_URL}
        bashio::log.debug "BORG_REPO set"
        return
    elif BORG_REPO="${_BORG_USER}@${_BORG_HOST}:${_BORG_PORT}${_BORG_REPONAME}"
    fi
    bashio::log.debug "BORG_REPO set"
    bashio::log.info "BORG_REPO=${BORG_REPO}"
    return
}

#function set_borg_repo_path {
#    bashio::log.debug "Setting BORG_REPO"
#    if [ ${#_BORG_REPO_URL} -gt 0 ]; then
#        BORG_REPO=${_BORG_REPO_URL}
#        bashio::log.debug "BORG_REPO set"
#        return
#    elif [ ${#_BORG_USER} -gt 0 ];then
#        BORG_REPO+="${_BORG_USER}@"
#    fi
#    if [ ${#_BORG_USER} -eq 0 ];then
#        BORG_REPO+="${_BORG_HOST}/${_BORG_REPONAME}"
#    else
#        BORG_REPO+="${_BORG_HOST}:${_BORG_REPONAME}"
#    fi
#    bashio::log.debug "BORG_REPO set"
#    return
#}

function generate_ssh_key {
    if ! bashio::fs.file_exists "${_BORG_SSH_KEY}"; then
        bashio::log.info "Generating borg backup ssh keys..."
        ssh-keygen -t ${_BORG_SSH_ENCRYTION} -P '' -f ${_BORG_SSH_KEY}
        bashio::log.info "key generated"
    fi
}

function show_ssh_key {
    bashio::log.info "This the ssh public key to set on you borg backup server authorized_keys file"
    bashio::log.info "************ SNIP **********************"
    echo
    cat ${_BORG_SSH_KEY}.pub
    echo
    bashio::log.info "************ SNIP **********************"
}

function add_borg_host_to_known_hosts {
    bashio::log.info "in add_borg_host_to_known_hosts"
    if ! bashio::fs.file_exists ${_BORG_SSH_KNOWN_HOSTS}; then
        if [[ ( ${#_BORG_USER} -gt 0 ) ]];then
            bashio::log.info "Adding host $1 into ${_BORG_SSH_KNOWN_HOSTS}"
            ssh-keyscan ${_BORG_HOST} >> ${_BORG_SSH_KNOWN_HOSTS}
        	bashio::log.info "known borgbackup hosts servers:"
			cat ${_BORG_SSH_KNOWN_HOSTS}
        else
            bashio::log.info "Local path ignoring ssh and unseting BORG_RSH"
            unset BORG_RSH
        fi
    fi
}

function init_borg_repo {
    if ! bashio::fs.directory_exists "${BORG_BASE_DIR}/.config/borg/security"; then
        bashio::log.info "Initializing backup repository"
        borg init --encryption=${_BORG_ENCRYPTION} --debug ${_BORG_USER}@${_BORG_HOST}:${_BORG_REPONAME}
    fi
}

function borg_create_backup {
    bashio::log.info "Start borg create"
#    borg create ${_BORG_DEBUG} --compression ${_BORG_COMPRESSION} --stats ${_BORG_USER}@${_BORG_HOST}::${_BORG_ARCHIVE} ${_BORG_PATH}
    borg create ${_BORG_DEBUG} --compression ${_BORG_COMPRESSION} --stats ssh://${BORG_REPO}::${_BORG_ARCHIVE} ${_BORG_PATH}
    bashio::log.info "End borg create --stats..."
}

function prune_archives {
    bashio::log.info 'Checking backups.'
    borg check --archives-only -P "${_BORG_ARCHIVE}"

    bashio::log.info 'Pruning old backups.'
    borg prune ${_BORG_PRUNE_OPTIONS} --list \
      -P ${_BORG_ARCHIVE} \
      || bashio::exit.nok "Could not prune backups."
}

sanity_checks
if [[ $borg_error -gt 0 ]];then
    bashio::log.warning "error state bailing out..."
    exit -1
fi
generate_ssh_key
show_ssh_key
set_borg_repo_path
add_borg_host_to_known_hosts

init_borg_repo
borg_create_backup
prune_archives
