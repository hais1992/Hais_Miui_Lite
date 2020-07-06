#!/bin/bash


BASE=../Rom/MIUI/UnpackedImg
SYSTEM=$BASE/system
VENDOR=$BASE/vendor


function replaceFiles()
{
   for file in `ls $1` #这里`为esc下面的按键符号
      do
         if [ -d $1"/"$file ] #这里的-d表示是一个directory，即目录/子文件夹
            then replaceFiles $1"/"$file $2 #如果子文件夹则递归
         else
            #echo $1"/"$file"-->"$2 #否则就能够读取该文件的地址
			echo "- 替换文件："$1"/"$file
			cp -rf $1"/"$file $2"/"$file
            #echo `basename $file` #读取该文件的文件名，basename是提取文件名的关键字
         fi
      done
}

replaceFiles ./system_files ./$SYSTEM/system

replaceFiles ./vendor_files ./$VENDOR













FS_PATH=$PROJECT"/Config/system_fs_config"
echo "system/xbin/busybox 0000 2000 00755" >> $FS_PATH
echo "system/xbin/zip 0000 2000 00755" >> $FS_PATH 

CTX_PATH=$PROJECT"/Config/system_file_contexts"
echo "/system/xbin/busybox u:object_r:busybox_exec:s0" >> $CTX_PATH
echo "/system/xbin/zip u:object_r:zip_exec:s0" >> $CTX_PATH 