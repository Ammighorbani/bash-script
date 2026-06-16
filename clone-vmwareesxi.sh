#!/bin/sh
#############################################################
# Smart VM Clone Automation for VMware ESXi
# - Auto-detects latest snapshot
# - Clones and consolidates disk
# - Expands disk to 50GB
# - Auto-detects new VMID
# - Powers on cloned VM automatically
#
# Author: Amir mahdi ghorbani (Ammighorbani)
#############################################################

# ---------------- CONFIG ----------------
SOURCE_VM_ID=3
SOURCE_VM_NAME="file-ubuntu-server"
CLONE_VM_NAME="monitoring-alerting-server"
DATASTORE_PATH="/vmfs/volumes/6927fa92-8d523dd8-68ea-5065f369c93c"
NEW_DISK_SIZE="50G"
# ----------------------------------------

SOURCE_VM_DIR="${DATASTORE_PATH}/${SOURCE_VM_NAME}"
CLONE_VM_DIR="${DATASTORE_PATH}/${CLONE_VM_NAME}"

echo "Starting Clone Process..."
echo "--------------------------------------------------"

# 1. Power off source VM
echo "Powering off source VM (ID: ${SOURCE_VM_ID})..."
vim-cmd vmsvc/power.off ${SOURCE_VM_ID}

# 2. Create clone directory
echo "Creating destination directory..."
mkdir -p "${CLONE_VM_DIR}"

# 3. Detect latest snapshot (if exists)
LAST_SNAP=$(ls -1 "${SOURCE_VM_DIR}"/${SOURCE_VM_NAME}-[0-9][0-9][0-9][0-9][0-9][0-9].vmdk 2>/dev/null | sort | tail -n 1)

if [ -n "$LAST_SNAP" ]; then
    echo "Snapshot detected: $(basename "$LAST_SNAP")"
    echo "Cloning from snapshot state..."
    SOURCE_DISK="$LAST_SNAP"
else
    echo "No snapshots detected. Cloning from base disk..."
    SOURCE_DISK="${SOURCE_VM_DIR}/${SOURCE_VM_NAME}.vmdk"
fi

# 4. Clone disk
echo "Cloning disk..."
vmkfstools -i "$SOURCE_DISK" "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmdk" -d thin

# 5. Expand disk to 50GB
echo "Expanding cloned disk to ${NEW_DISK_SIZE}..."
vmkfstools -X ${NEW_DISK_SIZE} "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmdk"

echo "--------------------------------------------------"

# 6. Copy and modify VMX
echo "Configuring VMX..."
cp "${SOURCE_VM_DIR}/${SOURCE_VM_NAME}.vmx" "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmx"

# Replace source name with clone name
sed -i "s|${SOURCE_VM_NAME}|${CLONE_VM_NAME}|g" "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmx"

# Ensure VMX points to correct consolidated disk
sed -i -E "s|${CLONE_VM_NAME}-[0-9]{6}\.vmdk|${CLONE_VM_NAME}.vmdk|g" "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmx"

# Cleanup conflicting entries
sed -i '/\.vmsn/d' "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmx"
sed -i '/snapshot/d' "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmx"
sed -i '/uuid.bios/d' "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmx"
sed -i '/uuid.location/d' "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmx"
sed -i '/vc.uuid/d' "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmx"
sed -i '/sched.swap.derivedName/d' "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmx"

echo "--------------------------------------------------"

# 7. Register new VM
echo "Registering cloned VM..."
vim-cmd solo/registervm "${CLONE_VM_DIR}/${CLONE_VM_NAME}.vmx"

# Small delay to ensure registration completes
sleep 2

# 8. Auto-detect new VM ID
NEW_VMID=$(vim-cmd vmsvc/getallvms | grep "${CLONE_VM_NAME}" | awk '{print $1}')

if [ -n "$NEW_VMID" ]; then
    echo "Detected new VM ID: ${NEW_VMID}"
    echo "Powering on cloned VM..."
    vim-cmd vmsvc/power.on ${NEW_VMID}
else
    echo "ERROR: Could not detect new VM ID."
fi

echo "--------------------------------------------------"

# 9. Power source VM back on
echo "Powering source VM back on..."
vim-cmd vmsvc/power.on ${SOURCE_VM_ID}

echo "Clone process completed successfully."