#!/bin/bash
echo "#####################################"
echo "#          FTP Config  v1.0         #"
echo "#####################################"
echo " "
echo "*   Enter '1' to START FTP server"
echo "*   Enter '0' to STOP FTP server"
echo "------------------------------------"
echo "*   Enter 'a' to AUTOCONFIG vsftpd"
echo "*   Enter 'i' to INSTALL vsftpd"
echo "------------------------------------"
echo -e "*   Enter your option: " | tr -d '\n';
read option;

if [ $option == 1 ]
then
   sudo systemctl restart vsftpd
   echo -e ".\n---\n"
   #echo -e "Your public IP is:";
   #curl ifconfig.me
   echo "  "
   echo "You can now access the FTP server locally"
   echo "by going to ftp://" | tr -d "\n"
   ip route list | grep -Eo 'src (addr:)?([0-9]*\.){3}[0-9]*' | tr -d ' src' | tr -d '\n'
   echo ":21"
   echo "Your username and password is the same as" 
   echo "your Linux username and password"
   echo -e "\nStarted all services! :)";
elif [ $option == 0 ]
then
   sudo systemctl stop vsftpd
   echo -e "---\nStopped all services!";
elif [ $option == a ]
then
  echo "chown_username=$USER" | tee -a vsftpd.conf
  sudo rm //etc/vsftpd.conf.backup
    sudo mv //etc/vsftpd.conf //etc/vsftpd.conf.backup
    sudo cp vsftpd.conf //etc/
    sudo systemctl restart vsftpd
    echo "You can now access the FTP server locally"
    echo "by going to ftp://" | tr -d "\n"
    ip route list | grep -Eo 'src (addr:)?([0-9]*\.){3}[0-9]*' | tr -d ' src' | tr -d '\n'
    echo ":21"
    echo "Your username and password is the same as" 
    echo "your Linux username and password"
    echo -e "Done! Restart script to STOP or START FTP server";
elif [ $option == i ]
then
    OSInfo=$(cat /etc/*-release)
    if [[ $OSInfo =~ Manjaro ]];
  then
      sudo pacman -Sy --noconfirm vsftpd
    elif [[ $OSInfo =~ Red ]];
  then
    sudo yum install vsftpd
  elif [[ $OSInfo =~ Ubuntu ]];
  then
    sudo apt-get update
    sudo apt-get install vsftpd
  else
      echo "False"
  fi
    echo -e "Done! Restart script to AUTOCONFIGURE";
fi
