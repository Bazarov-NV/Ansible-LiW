# install mount utils
#sudo apt update
#sudo apt install nfs-common
#sudo apt install cifs-utils

#sudo mkdir /mnt/server_antor

#add to fstab repo folder
#//server.ANTOR.msk/антор/Отдел\040внедрения/Релизы/LogistinWeb/Repo /mnt/server_antor cifs username=nbaz,password=$Dbcgu!2089,domain=ANTOR.msk,nofail 0 0

#mount repo folder from command line
#sudo mount -t cifs '//server.ANTOR.msk/антор/Отдел Внедрения/Релизы/LogistinWeb/Repo' /mnt/server_antor -o username=nbaz,password=\$Dbcgu\!2089,domain=ANTOR.msk

# install ssh
#sudo apt update
#sudo apt install openssh-server

#Требуется добавить предварительно зайти по ssh на target host, чтобы 
# прописать host key 