#!/bin/bash

user_check() {
  if [ `id -u` -eq 0 ]
  then 
    echo
    echo "You are the root user, So, you are allow to execute this script"
    sleep 2
    echo 
  else
    exit 1
  fi
 	}

welcome() {
  echo
  echo "**********************************************************"
  echo "Welcom to Automation Git installation through Shell script"
  echo "**********************************************************"
  echo
  sleep 2
  }
usage_of_script() {
   if [ $2 -ne 2 ]
   then
     echo "usage of this script is: "
     echo "$1  <git_required_tools.txt> <git_latest_tar_url.txt>"
     echo  
     exit 2
   fi
	}
log_file_location() {
    if [ -d "/tmp/git_installed_logs" ]
    then 
      echo "cleaning old log file under: /tmp/git_installed_logs"
      echo 
      cd /tmp/git_installed_logs/
      rm -rf *
      cd -
    else
      echo "creating a directory for logs"
      mkdir -p /tmp/git_installed_logs
      echo 
    fi

	}

Tools_verification() {
    echo "Please wait checking required tools for git"
    echo
    echo "If required tools are not there then our script will install using yum command"
    sleep 2
    for each in `cat $1`
    do
      #echo "$each"
      check_flag=`yum list installed | grep $each`
      if [ -z "$check_flag" ]
      then
        echo
        echo "Installing $each Tool"
        sleep 1
        yum install $each -y  >> /tmp/git_installed_logs/yum_logs.txt
      fi
    done
    yum install gcc -y >> /tmp/git_installed_logs/yum_logs.txt
    echo
    sleep 2
        }

download_git_tar_ball() {
    echo
    url_link=`cat $1`
    echo "Downloading the git tar ball with the link of $url_link"
    #download_dir="/tmp"
    cd /tmp
    wget $url_link
    cd -
    }

un_tar() {
   tar_gz_file=`cat $1 | cut -d '/' -f 8`
   echo "tar file is: $tar_gz_file"

   sleep 3
   cd "/tmp"
   tar -xvzf $tar_gz_file
        }

git_dir_name() {
   tar_gz_name=$1
   echo "The tar_gz_name is: $tar_gz_name"
   sleep 3
   tar_file=`echo ${tar_gz_name%.*}`
   git_dir=`echo ${tar_file%.*}`
   echo "Git dir is: $git_dir"
  
	} 

install_git() {
   cd /tmp	
   cd $1
   ./configure
   make
   make install
  	}

create_soft_lin() {
   yum remove git -y >> /tmp/git_installed_logs/yum_logs.txt
   ln -s /usr/local/bin/git /bin/git
	}
latest_version_is() {
   echo 
   echo "***********************************************"
   echo "Now the latest git version is:`git --version`"
   echo "***********************************************"
   echo 
   echo "Thank you for using this script"
   echo "Still if you want to update the git change the link in the file $1 and try it once againg"
   echo "Bye Have a great day"
   echo 
	}
   
clear
script_pwd=`pwd`
user_check
welcome
usage_of_script $0 $#
log_file_location
Tools_verification $1 
cd $script_pwd
download_git_tar_ball $2
cd $script_pwd
un_tar $2
cd $script_pwd
git_dir_name $tar_gz_file
cd $script_pwd
install_git $git_dir
cd $script_pwd
create_soft_link
latest_version_is $2















