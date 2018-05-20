#!/bin/bash


check_user() {
    if [ `id -u` -eq 0 ]
    then
        sleep 2
        #user_info="root"
        echo "You are the root use so you are allowed to execute this script"
        echo "Enjoy wiht Git Installation through Automation Script"
    else
        echo "You are not the root user."
        echo "You cant execute this script"
        echo "Sorry bye!!"
        exit 1
    
    fi
	}

usage_of_script() {
    if [ $2 -ne 4 ]
    then
      sleep 2
      echo "Execute this script as follows"
      echo "$0  <git_required_tools.txt>   <git_latest_tar_url.txt> <download_loc> <install_loc> "
      echo 
      echo
      exit 2
    fi
	}

Welcome_message() {
    #clear
    echo "*********************************************"
    echo "Welcome to Git installation with Shell Script"
    echo "**********************************************"
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
        yum install $each -y 
      fi
    done
    echo
    sleep 2
        }
download_git_tar_ball() {
    echo
    url_link=`cat $1`
    echo "Downloading the git tar ball with the link of $url_link"
    download_dir=$2
    if [ -d "$download_dir" ]
    then
      cd $download_dir
      wget $url_link
    else
      echo
      echo "Your given dir is not existing, So we are creating it"
      mkdir -p $2
      cd $2
      wget $url_l
    fi
	}

un_tar() {
   cd $1
   tar_gz_file=`cat $2 | cut -d '/' -f 8`
   echo "tar file is: $tar_gz_file"

   sleep 3
   cd $3
   tar -xvzf $tar_gz_file 
	}

git_dir_name() {
   tar_gz_name=$1
   echo "The tar_gz_name is: $tar_gz_name"
   sleep 3
   echo "The tar_gz_name is: $tar_gz_name"
   tar_file=`echo ${tar_gz_name%.*}`
   git_dir=`echo ${tar_file%.*}`
   echo "Git dir is: $git_dir"


	}

install_git() {
   cd $1
   cd $2
   pwd
   if [ ! -d $3 ]
   then
     echo "We dont have $3 path. So, creating it ......."
     sleep 2
     mkdir -p $3
   fi
   echo "$3"
   sleep 5
   ./configure --prefix=$3
   make
   make install
   yum remove git -y
   cd $3
   cd bin
   pwd 
   sleep 5
   git_path="`pwd`/git"
   echo "git_path is: $git_path"
   ln -s $git_path /bin/git
   echo 
   echo 
   echo "Now your latest git version is:     `git --version`"

  	}


clear
my_pwd=`pwd`
#check_user
#usage_of_script $0 $#
#Welcome_message  
#Tools_verification $1
#download_git_tar_ball $2 $3
un_tar $my_pwd $2 $3  
git_dir_name $tar_gz_file
install_git $3 $git_dir $4


















