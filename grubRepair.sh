## PROPERTY OF LINUXBBQ ##

#!/bin/bash

# Arguments:
#        $1: CHROOT_DEVICE
#        $2: CHROOT_MOUNTPOINT

# And replace the COMMANDS array definition in yje main section of
# this script with the series of commands you want to run in the
# chroot

# e.g. chroot.sh /dev/mapper/VG10-linuxBBQ

# Is it possible to run more than 1 command in one run?
# YES! By putting the commands in an array and passing the array to the
# do_chroot function.

# WARNING: The scripts uses 'indirect variables', which is a bash feature only!


usage () {
    echo -e "Usage:\n \
       $0 CHROOT_DEVICE CHROOT_MOUNTPOINT COMMAND"
    exit 1
}


# as_fn_set_status STATUS
# -----------------------
# Set $? to STATUS, without forking.
as_fn_set_status ()
{
  return $1
} # as_fn_set_status

# as_fn_exit STATUS
# -----------------
# Exit the shell with STATUS, even in a "trap 0" or "set -e" context.
as_fn_exit ()
{
  set +e
  as_fn_set_status $1
  exit $1
} # as_fn_exit

setup () {
    local chroot_mountpoint="$1"
    if [[ ! -d "$chroot_mountpoint" ]]; then
        mkdir -p "chroot_mountpoint"
    fi
}

breakdown () {
    local chroot_mountpoint="$1"
    do_bind_unmounts $chroot_mountpoint
    umount "$chroot_mountpoint"
}

bind_it () {
    mount --bind $1 $2
}

do_bind_mounts () {
    local mountpoint chroot_mountpoint="$1"
    for mountpoint in "/dev/" "/dev/pts" "/dev/shm" "/proc" "/sys"; do
        bind_it "$mountpoint" "${chroot_mountpoint}${mountpoint}"
    done
}

do_bind_unmounts () {
    local mountpoint chroot_mountpoint="$1"
    for mountpoint in "/dev/pts" "/dev/shm" "/dev" "/proc" "/sys"; do
        umount "${chroot_mountpoint}${mountpoint}"
    done
}

# main program starts here
do_chroot () {
    local CHROOT_DEVICE CHROOT_MOUNTPOINT CHROOT_COMMAND
    declare -a CHROOT_COMMANDS
    local ARRAY_NAME CHROOT_COMMANDS
   
    ARRAY_NAME=$1[@]
    # Uses variable indirection, which is a bashism!
    CHROOT_COMMANDS=("${!ARRAY_NAME}")
    CHROOT_DEVICE="$2"
    CHROOT_MOUNTPOINT="$3"
    [[ x"$CHROOT_DEVICE" = "x" ]] && usage
    [[ x"$CHROOT_MOUNTPOINT" = "x" ]] && usage
    [[ $# -eq 0 ]] && usage
    [[ "$(id -u)" -eq 0 ]] || { echo -e "\tRoot permissions required...\n"; exit 1; }
    [[ -b $CHROOT_DEVICE ]] || { echo -e "\t$CHROOT_DEVICE is not a block device...\n"; exit 1; }


    # Catch error status, even normal exit. Make sure anything mounted
    # by this script is unmounted, no matter if the script exits
    # normally or not.
    trap 'exit_status=$?
    breakdown $CHROOT_MOUNTPOINT
    exit $exit_status
' 0
    for ac_signal in 1 2 13 15; do
        trap 'ac_signal='$ac_signal'; as_fn_exit 1' $ac_signal
    done
    ac_signal=0

    setup
   
# Attempt mount
    mount "$CHROOT_DEVICE" "$CHROOT_MOUNTPOINT"
    # returns status 32 when already mounted
    if [[ $? != 0 && $? != 32 ]]; then
        echo "Could not mount $CHROOT_DEVICE on $CHROOT_MOUNTPOINT"
        exit 1
    fi
    do_bind_mounts $CHROOT_MOUNTPOINT
   
    # run teh command
    for COMMAND in "${CHROOT_COMMANDS[@]}"; do
        chroot "$CHROOT_MOUNTPOINT" ${COMMAND}
    done
}

# main program starts here
# create an array with commands+arguments to run in the chroot

CHROOT_DEVICE="$1"
CHROOT_MOUNTPOINT="$2"

declare -a COMMANDS
# Change the COMMANDS definition to the series of commands you want to run

# -----------------------------------------------------------------------

# Example 1: Install grub to the MBR of your HD and run update-grub
    COMMANDS=( \ 'grub-install /dev/sda' \ 'update-grub' \ )


# Example 2:
#     run apt-get update and apt-get dist-upgrade in a system you chroot into
# COMMANDS=( \
#     'apt-get update' \
#     'apt-get dist-upgrade' \
#     )

# Example 3: install the 'lvm2' package in a system you chroot into
#     and run update-initrams
# COMMANDS=( \
#     'apt-get update' \
#     'apt-get install lvm2' \
#     '/usr/sbin/update-initramfs -u -vvv /initrd.img' \
#     )


# -----------------------------------------------------------------------

do_chroot COMMANDS $CHROOT_DEVICE $CHROOT_MOUNTPOINT
