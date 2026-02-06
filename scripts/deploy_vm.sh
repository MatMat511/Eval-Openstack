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
USER-DATA="/var/snap/microstack/common/var/user-init.yaml"

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
 --user-data "$USER-DATA" \
 --config-drive true
 "$VM_NAME"

# Attendre que la VM soit ACTIVE
while true; do
  STATUS=$(microstack.openstack server show "$VM_NAME" -f value -c status 2>/dev/null || echo "ERROR")
  if [ "$STATUS" = "ACTIVE" ]; then
    break
  elif [ "$STATUS" = "ERROR" ]; then
    echo "Erreur : la VM $VM_NAME est en état ERROR"
    exit 1
  else
    echo "État actuel de la VM $VM_NAME : $STATUS, attente..."
    sleep 5
  fi
done1~# Attendre que la VM soit ACTIVE
while true; do
  STATUS=$(microstack.openstack server show "$VM_NAME" -f value -c status 2>/dev/null || echo "ERROR")
  if [ "$STATUS" = "ACTIVE" ]; then
    break
  elif [ "$STATUS" = "ERROR" ]; then
    echo "Erreur : la VM $VM_NAME est en état ERROR"
    exit 1
  else
    echo "État actuel de la VM $VM_NAME : $STATUS, attente..."
    sleep 5
  fi
done

#Cette partie ne marche pas à cause de la commande wait qui n'existe
# Attente que la VM soit active et récupération de l'IP
#sudo microstack.openstack server wait $VM_NAME"
#IP=$(sudo microstack.openstack server show $VM_NAME" \
# -f value -c addresses | cut -d= -f2)

#echo La VM $VM_NAME est déployée avec IP : $IP"
