#!/bin/bash


##################################
#### Syntax of a Bash command ####
##################################

# command [-options] [arguments]
# Examples:
ls -l				# list what is the the current folder, option= by line
# head -n 30 sequence.fasta	# 
# cp -r ../exercise1 exercises/ #

# Get help on a specific command:
man ls

##################################
#### Tree structure of files #####
##################################

# “/”    root directory
# “~"    home directory
# “.”    current/working directory
# “..”   parent directory
# “-”    last working directory
# Change directory:  cd [directory name]

# let's build the topology for the exercise in slide 15
cd ~/work
mkdir -p bash_slurm_training
cd bash_slurm_training
mkdir -p bash
cd bash
mkdir -p a_small_exercise
mkdir a_small_exercise/lecture
mkdir a_small_exercise/lecture/lecture{1..2}
mkdir a_small_exercise/lecture/lecture2
mkdir a_small_exercise/practical
mkdir a_small_exercise/exercises
mkdir a_small_exercise/exercises/exercise{1..2}

# let's now move across this project structure with the command 'cd' 
cd a_small_exercise # move to the directory "a_small_exercise"
# slide 16 request 1, move to lecture 1:
cd lecture/lecture1
# request2: 
cd ../..
# now continue with request 3-4, and play with the cd command


ls #(list directory contents)
ls -lah
ls -lah work/

tree #(list contents of directories in a tree-like format)
cd ~/work/
tree
tree -dL 2

cd ~/work/bash_slurm_training/bash/a_small_exercise/
pwd #(print working directory)
pwd


###########################################
#### Manipulate files and directories #####
###########################################
cd ~/work/bash_slurm_training/bash/

# Create and remove files/directories
# touch / rm [file_name]
touch my_file.txt
ls -lh my_f*
rm my_file.txt 
ls -lh my_f* 
# what did the rm function do ???

# mkdir / rmdir [dir_name]
mkdir mydir
ls -lh myd*
rmdir mydir
ls -lh myd*

# Copy files/directories
# cp [-r] [source] [destination]
# cp file1 file2
# cp -r dir1 dir2
touch my_file.txt
cp my_file.txt my_copied_file.txt
ls -lh my_*
mkdir mydir
cp -r mydir mycopiedir
ls -lh my*

# Move/rename files/directories
# mv [source] [destination]
# mv file_name existing_dir_name
# mv old_file_name new_file_name
# mv old_file_name existing_dir_name/new_file_name
mv my_file.txt mycopiedir/my_moved_file.txt

#####################################
#### Find files and directories #####
#####################################
# find [dir_name] [-options] [parameter]
find mycopiedir/ -name "*.txt"
find -type d
find -type f

###############################
#### Display file content #####
###############################
shuf -i 01-200 -n 200 > my-big-file
# cat [file_name]
cat my-big-file
more my-big-file
less my-big-file
head my-big-file
tail my-big-file
# what is the difference between more and less ?

#################################
#### Piping and redirection #####
#################################
# Appending commands together with a pipe
echo "hello world" | grep hello
echo "hello world" | grep hel
echo "hello world" | grep lo
echo "je ne suis pas content" | grep content
# Sending output of a command to a file
echo hello world > hello.txt
# Appending output of a command to a file (no overwriting)
echo "hello world" >> hello.txt
echo "hello you" >> hello.txt
echo "hello me" >> hello.txt
echo "hello tout court" >> hello.txt
echo "I am appending whatever come to my mind to this file" >> hello.txt
# Getting input to a command from a file
cat < hello.txt

#####################################
#### Searching and word counting ####
#####################################
#Searching words from files
#Try with grep -n, -o or -B [n] -A [n]
grep 'hello' hello.txt
grep -n 'hello' hello.txt
grep -o 'hello' hello.txt
grep -c 'hello' hello.txt
grep -c 'whatever' hello.txt

#Try this -
grep "hello" hello.txt | wc -l
grep "I am appending whatever come to my mind to this file" hello.txt | wc -l
grep "1" my-big-file  | wc -l
grep 1 my-big-file | sort | uniq -c 
# are all occurence of my shuffled file unique ???

#################################
#### Owners and permissions #####
#################################
# Owners:
# The user who owns the file (u), usually the creator of the file
# The group that owns the file (g). If a user is a member of a certain group that owns a file, the user will also have certain permissions on that file.
# The others, the rest of the world (o). In short, everyone is neither the owner of the file, nor a member of the group that owns the file.

# Permissions:
# Reading a file (r)
# Writing a file (w)
# Executing a file (x)

# Show the permissions on the files in a directory:
ls -lh

# The first symbol indicates the nature of the file:
# d    directory
# -    file
# l    symbolic link

# chmod (change mode, change permissions)
# 3 elements to choose:

# To whom the change applies : u (user), g (group), o (others), a (all)
# The change you want to make: +, -
# The right we want to change: r, w, x

# Examples :
ls -lh hello.txt
chmod o-r hello.txt # the "OTHERS" can't red my file anymore
ls -lh hello.txt
#
ls -lh my-big-file
chmod u+rwx,g+rx-w,o+r-wx my-big-file
ls -lh my-big-file
#
# chown (change owner) Example: chown toto fichier1

###################################################
#### Download files from online repositories ######
###################################################
mkdir -p ~/work/bash_slurm_training/data/
mkdir -p ~/work/bash_slurm_training/data/genomics
cd ~/work/bash_slurm_training/data/genomics

# Wget: let's try with the WorldClim min temperature data 
wget --no-check-certificate https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_10m_tmin.zip 

# cURL: let's try with one of Yersinia pestis’ reference genome
curl -L "https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/015/336/265/GCF_015336265.1_ASM1533626v1/GCF_015336265.1_ASM1533626v1_genomic.fna.gz"  -o GCF_015336265.1_ASM1533626v1_genomic.fna.gz


###################################################
#### Zip-Unzip files: tar, gzip, gunzip      ######
###################################################

# gunzip: let's unzip the WorldClim data and the Yersinia  genome
unzip wc2.1_10m_tmin.zip 
gunzip GCF_015336265.1_ASM1533626v1_genomic.fna.gz

# tar: let's compress folders of files for long term storage
mkdir -p zipping ; mkdir -p zipping/zippings_{001..100}/
tar -zcf my-archive-name.tar.gz zipping
du -chs ./*
# How much disk space is saved by the compression?

# lets now remove the zipping folder
rm -r zipping 





