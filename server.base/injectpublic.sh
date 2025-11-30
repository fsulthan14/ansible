#!/bin/bash

dirName=$(dirname "${0}")
USERNAME=faqih

echo "[INFO] Create faqih User.."
id ${USERNAME} &> /dev/null && userdel -rf ${USERNAME} &> /dev/null
getent group ${USERNAME} &> /dev/null && groupdel ${USERNAME} &> /dev/null

groupadd ${USERNAME}
useradd -m -s /bin/bash -c "" -u 2000 -g ${USERNAME} -G sudo ${USERNAME}

echo "[INFO] Add base public key"
mkdir -p /home/${USERNAME}/.ssh
cp "${dirName}/pub.key" /home/${USERNAME}/.ssh/authorized_keys

chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh
chmod 700 /home/${USERNAME}/.ssh
chmod 600 /home/${USERNAME}/.ssh/authorized_keys

echo "[INFO] Add Sudoers"
echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME}
chmod 440 /etc/sudoers.d/${USERNAME}

echo "[INFO] Done"