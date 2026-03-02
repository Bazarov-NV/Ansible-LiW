# Скрипты, необходимые для подготовки ansible хоста к копированию дистрибутивов LiW на таргет хост клиента   
#
# необходимо примонтировать папку Релизов liw  с внутреннего сервера 
# АНТОР, для этого вначале ставим необходмиые утилиты
#
# install mount utils
#sudo apt update
#sudo apt install nfs-common
#sudo apt install cifs-utils
# создаем папку монтирования
#sudo mkdir /mnt/server_antor
#команда монтирования
#sudo mount -t cifs '//server.ANTOR.msk/антор/Отдел Внедрения/Релизы/LogistinWeb/Repo' /mnt/server_antor -o username=nbaz,password=\$Dbcgu\!2089,domain=ANTOR.msk
#добавляем в fstab
#//server.ANTOR.msk/антор/Отдел\040внедрения/Релизы/LogistinWeb/Repo /mnt/server_antor cifs username=nbaz,password=$Dbcgu!2089,domain=ANTOR.msk,nofail 0 0

# install ssh
#sudo apt update
#sudo apt install openssh-server

# install 7z
# sudo apt install 7zip

# Требуется предварительно зайти вручную по ssh на target host, чтобы 
# прописался host key 
