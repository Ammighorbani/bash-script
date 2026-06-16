#############################################################
# I wrote this automation to make a clone of my vm machiens
#
# Author: Amir mahdi ghorbani (Ammighorbani)
#############################################################

# Show whole vms information
vim-cmd vmsvc/getallvms

# Poweroff your vm with it's id
vim-cmd vmsvc/power.off 3

# Move to datastore
cd /vmfs/volumes/6927fa92-8d523dd8-68ea-5065f369c93c

# Create directory for you clone vm
mkdir monitoring-alerting-server

# Clone from last version or snapshot
vmkfstools -i file-ubuntu-server/file-ubuntu-server-000002.vmdk monitoring-alerting-server/monitoring-alerting-server.vmdk -d thin

# Copy configuration file
cp file-ubuntu-server/file-ubuntu-server.vmx monitoring-alerting-server/monitoring-alerting-server.vmx

# Change name in .vmx
sed -i 's|file-ubuntu-server|monitoring-alerting-server|g' monitoring-alerting-server/monitoring-alerting-server.vmx

# Remove references of snapshot & uuid
sed -i '/snapshot/d' monitoring-alerting-server/monitoring-alerting-server.vmx
sed -i '/parentFileNameHint/d' monitoring-alerting-server/monitoring-alerting-server.vmx
sed -i '/uuid.bios/d' monitoring-alerting-server/monitoring-alerting-server.vmx
sed -i '/uuid.location/d' monitoring-alerting-server/monitoring-alerting-server.vmx

# Register vm in ESXI
vim-cmd solo/registervm /vmfs/volumes/6927fa92-8d523dd8-68ea-5065f369c93c/monitoring-alerting-server/monitoring-alerting-server.vmx

# Check vmID
vim-cmd vmsvc/getallvms

# Poweron first vm
vim-cmd vmsvc/power.on 3

# Poweron cloned vm
read -p "Enter VM ID: " VMID
vim-cmd vmsvc/power.on "$VMID"