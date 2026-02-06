#!/bin/bash

# Vérification des paramètres
if [ "$#" -ne 1 ]; then
 echo "Usage: $0 <nom_de_la_vm>"
 exit 1
fi

VM_NAME=$1
IMAGE="Alpine_3.21"
FLAVOR="Eval"
NETWORK="LAN-LABO"

# Vérifie si la VM existe déjà
if sudo microstack.openstack server list | grep -q "$VM_NAME"; then
 echo "La VM existe déjà !"
 exit 0
fi

# Création de la VM
sudo microstack.openstack server create \
 --image "$IMAGE" \
 --flavor "$FLAVOR" \
 --network "$NETWORK" \
 "$VM_NAME"


#Cette partie ne marche pas à cause de la commande wait qui n'existe
# Attente que la VM soit active et récupération de l'IP
#sudo microstack.openstack server wait $VM_NAME"
#IP=$(sudo microstack.openstack server show $VM_NAME" \
# -f value -c addresses | cut -d= -f2)

#echo La VM $VM_NAME est déployée avec IP : $IP"
