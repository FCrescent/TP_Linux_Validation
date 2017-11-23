#!/bin/sh
echo "Vous allez devoir entrer votre mot de passe pour installer Vagrant. "
sudo apt-get install vagrant 
vagrant init
$choixBox=0
until [ "$choixBox" = "1" ] || [ "$choixBox" = "2" ];
do
echo "Vous etes sur le point de créer une Vagrant, choisissez une version de box:"
read -p "Tapez \"1\" puis Entree pour xenial64; Tapez \"2\" puis Entree pour trusty64 " choixBox

	if [ "$choixBox" = "1" ];then
		$Box="ubuntu/xenial64"
	elif [ "$choixBox" = "2" ];then
		$Box="ubuntu/trusty64"
	else
		echo "Veuillez essayer de nouveau en faisant attention aux consignes. "
done
read -p "Ecrivez le chemin du dossier Vagrant (dossier LOCAL synchronise avec le dossier SERVEUR) au format \".\/monDossier\" puis Entree  " pathLocal 
read -p "Ecrivez le chemin du dossier Vagrant (dossier SERVEUR synchronise avec le dossier LOCAL) au format \"/var/www/monDossier\" puis Entree  " pathServeur
 
echo "# -*- mode: ruby -*-
\# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "$Box"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.synced_folder "$pathLocal", "$pathServeur"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
end
end" > Vagrantfile
vagrant up
echo "Si vous souhaitez a la gestion de votre vagrant (pour installer des paquets tels qu'Apache, MySQL ou PHP) vous devrez le faire après ce script en utilisant la ligne de commande \"vagrant ssh\" "
echo "Vous allez devoir entrer votre mot de passe pour installer VirtualBox. "
sudo apt-get install virtualbox-qt





