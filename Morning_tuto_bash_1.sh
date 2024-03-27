#!/bin/bash

# Connect to the genobioinfo cluster from a terminal:
ssh login@genobioinfo.toulouse.inrae.fr
# + enter your password

# Or use MobaXterm (cf. slide #7)

#####################################
#### 1. Syntax of a Bash command ####
#####################################

# command [-options] [arguments]
# Examples:

# list what is the the current folder, option: in the long format (-l)
ls -l
# list what is the the current folder, option: in the long format (-l), print hidden files (-a), print file size in 'human-readable' format (-h)
ls -lah work/

# get tree structure, option: print only directories (-d), depth of the tree=2 (-L 2)
tree -dL 2

# get help on a specific command:
man ls

# print working directory:
pwd

#####################################
#### 2. Tree structure of files #####
#####################################

# “/”    root directory
# “~"    home directory
# “.”    current/working directory
# “..”   parent directory
# “-”    last working directory
# Change directory:  cd [directory name]

# let's build the topology for the exercise in slide 17

# go in the work space:
cd ~/work
# create the directory bash_slurm_training (option -p means that no error is printed if the folder already exists, and make parent directories if needed):
mkdir -p bash_slurm_training
# go in the newly created directory:
cd bash_slurm_training
# create a sub-directory and go inside:
mkdir -p bash
cd bash
# create the structure of directories used for the exercise:
mkdir -p a_small_exercise
mkdir a_small_exercise/lecture
mkdir a_small_exercise/lecture/lecture{1..2}
mkdir a_small_exercise/lecture/lecture2 # why do you have an error message here?
mkdir a_small_exercise/practical
mkdir a_small_exercise/exercises
mkdir a_small_exercise/exercises/exercise{1..2}

# let's now move across this directory structure with the command 'cd':
cd a_small_exercise # move to the directory "a_small_exercise"
# explore the directory:
ls -l # list directory contents
tree # list contents of directories in a tree-like format
pwd # print working directory

# and follow the exercise on slide 17:
# request 1:
cd lecture/lecture1
# request 2: 
cd ../..
# request 3:

# request 4:



##############################################
#### 3. Manipulate files and directories #####
##############################################

# go in the bash directory (if you are elsewhere):
cd ~/work/bash_slurm_training/bash/

# create and remove files/directories
# touch / rm [file_name]
touch my_file.txt
ls -lh
rm my_file.txt 
ls -lh
# what did the rm function do?

# mkdir / rmdir [dir_name]
mkdir mydir
ls -lh
rmdir mydir # rm -r mydir also deletes directories
ls -lh

# Copy files/directories
# cp [-r] [source] [destination]
# cp file1 file2
# cp -r dir1 dir2
touch my_file.txt
cp my_file.txt my_copied_file.txt
ls -lh
mkdir mydir
cp -r mydir mycopiedir
ls -lh

# Move/rename files/directories
# mv [source] [destination]
# mv file_name existing_dir_name
# mv old_file_name new_file_name
# mv old_file_name existing_dir_name/new_file_name
mv my_file.txt mycopiedir/my_moved_file.txt
tree

########################################
#### 4. Find files and directories #####
########################################
# find [dir_name] [-options] [parameter]
find mycopiedir/ -name "*.txt" # '*' is a wildcard that means any character (0 or several), we will present the wildcards later. Here you search for all files ending with .txt
find -type d
find -type f

##################################
#### 5. Display file content #####
##################################
shuf -i 01-200 -n 200 > my-big-file # shuf generates random permutations
# cat [file_name]
cat my-big-file
more my-big-file
less my-big-file
head my-big-file
tail my-big-file
# what is the difference between more and less?


#########################################
#### 6. Searching patterns in files #####
#########################################

# create liste_de_courses.txt:
nano liste_de_courses.txt
# write the list in the nano editor (use the arrow keys to move within the file! the mouse won't help you inside nano):
pommes gala
pommes granny
poires
fromage
farine de froment

# Use the following shortcuts to save and quit:
# Ctrl+O and then Enter to save
# Ctrl+X to quit

# check the content of liste_de_courses.txt
cat liste_de_courses.txt

# now test the examples from slide 23:
grep "pommes" liste_de_courses.txt
grep "from" liste_de_courses.txt
grep "^from" liste_de_courses.txt
grep "t$" liste_de_courses.txt
grep -v "po" liste_de_courses.txt
grep -c "^po" liste_de_courses.txt
grep -n "^po" liste_de_courses.txt

# count the number of lines containing the letter m:

# count the number of lines that do not begin the letter f:

# print the lines that contain the letter m, with line number:



####################################
#### 7. Piping and redirection #####
####################################

# Appending commands together with a pipe
echo "hello world" | grep hello
echo "hello world" | grep hel
echo "hello world" | grep lo
echo "je ne suis pas content" | grep content

grep "^from" liste_de_courses.txt | wc -l
# wc is a command to count words in a file, the option -l counts the number of lines


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


###############################################
#### 8. Use grep, | and wc -l on hello.txt ####
###############################################

# searching words in hello.txt
grep 'hello' hello.txt
grep -n 'hello' hello.txt
grep -o 'hello' hello.txt
grep -c 'hello' hello.txt
grep -c 'whatever' hello.txt
# what are the options -B and -A?
# try with grep -B [n] or -A [n]

# piping the output of grep:
grep "hello" hello.txt | wc -l
grep "I am appending whatever come to my mind to this file" hello.txt | wc -l
grep "1" my-big-file  | wc -l
grep 1 my-big-file | sort | uniq -c 
# are all occurence of my shuffled file unique?
# have a look at the manual of sort and uniq!


####################################
#### 9. Owners and permissions #####
####################################
# Owners:
# The user who owns the file (u), usually the creator of the file
# The group that owns the file (g). If a user is a member of a certain group that owns a file, this user will also have certain permissions on that file.
# The others, the rest of the world (o). In short, all the people that are neither the owner of the file, nor a member of the group that owns the file.

# Permissions:
# Reading a file (r)
# Writing a file (w)
# Executing a file (x)

# Show the permissions on the files in a directory:
ls -l

# The first symbol indicates the nature of the file:
# d    directory
# -    file
# l    symbolic link

# chmod (change mode, change permissions)
# 3 elements to choose:

# To whom the change applies : u (user), g (group), o (others), a (all)
# The change you want to make: + (add), - (remove)
# The right we want to change: r, w, x

# Examples :
ls -l hello.txt
chmod o-r hello.txt # the "OTHERS" can't red my file anymore
ls -l hello.txt

ls -l my-big-file
chmod u+rwx,g+rx-w,o+r-wx my-big-file
ls -l my-big-file

# chown (change owner) Example: chown toto fichier1

#######################################################
#### 10. Download files from online repositories ######
#######################################################
mkdir -p ~/work/bash_slurm_training/data/
mkdir -p ~/work/bash_slurm_training/data/genomics
cd ~/work/bash_slurm_training/data/genomics

# Wget: let's try with the WorldClim min temperature data 
wget --no-check-certificate https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_10m_tmin.zip 

# cURL: let's try with one of Yersinia pestis’ reference genome
curl -L "https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/015/336/265/GCF_015336265.1_ASM1533626v1/GCF_015336265.1_ASM1533626v1_genomic.fna.gz"  -o GCF_015336265.1_ASM1533626v1_genomic.fna.gz


###################################################
#### 11. Zip-Unzip files: tar, gunzip, unzip ######
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





