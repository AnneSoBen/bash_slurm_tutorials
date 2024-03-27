#!/bin/bash

# get to the right directory
cd ~/work/bash_slurm_training/bash
mkdir -p morning_tutorial_3
cd morning_tutorial_3

###############################
#### Get commands’ HISTORY ####
###############################

# Print the last [thousand] commands’ history, therefore we pipe it to head -55
history | head 55

# or the last n [25] commands
history 25

# clear [-c] your commands’ history (if you have something to hide)
history -c 

# save your commands’ history to a permanent file
history 500 > ./the_true_history

# more options with the manual’s instructions
man history

###############################
#### Create symbolic links ####
###############################

# Organizes your files and avoid duplicating them !
# Soft links: like windows shortcut [ln -s]
dd if=/dev/zero of=my-2mb-file bs=100000 count=20 
ln -s my-2mb-file my-2mb-file-softlink        #just a light link  

# Hard links: an additional name/location for an existing file [ln]
ln my-2mb-file my-2mb-file-hardlink            #copied the size but not using more space  
ls -lh my-2mb-file*    
du -chs ./ 

# How does a soft link is impacted by a soft change
echo "super_important" > superfile.txt 	# create a file
ln -s superfile.txt superfile.slink.txt # create a soft link of this file
ls -lh super* 				# list the created content
sed -i 's/sup/sap/' superfile.slink.txt # modify the soft link file
head superfile.slink.txt # print the first lines of the soft link file
head superfile.txt # print the first lines of the original file
ls -lh super* # list the  content
# what happened with my original file ????
# what happened with my soft link ????
# extract their properties from the above experience

# How does a hard link is impacted by a hard modification
ln -s superfile.txt superfile.hlink.txt # create a hard link
ls -lh super* 				# list the created content
sed -i 's/sup/sip/' superfile.hlink.txt # modify the hard link file
head superfile.hlink.txt 		# print the first lines of the hard link file
head superfile.txt			# print the first lines of the original file
ls -lh super*   # list the  content
# what happened with my original file ????
# what happened with my hard link ????

# what was the difference between hard and soft ?
# extract their properties from the above experience
                    

####################################################
#### Jokers / wildcards and regular-expressions ####
####################################################

# signification			bash
# joker (1 character)		?
# joker (several characters)	*
# character among …            [...]
# character except …            [!...]
# characters ? *                \? \*

# list all files with extension .txt:
ls *.txt

# list files for individuals from SX00 to SX09
touch individual_SX{00..25}.txt # let's create these files first
ls individual_SX0?.txt

# list SX and SY files from individual 01:
touch individual_SY{00..25}.txt
ls individual_S[XY]01.txt

# What is that one doing ????
ls individual_S[XYZ][!023]1.txt

#############################
#### Regular-expressions ####
#############################

# Regex are very useful for complex requests 
# start of a line                 	   ^
# alphanumeric character string       	 [A-Z0-9]
# other characters allowed            	[._%+-]
# character string min,max length        {2,}
# character .                       	 \. 
# end of a line                    	$

# Get properly formatted emails from a file
echo my-professional-email@bushpig-hunter.wwf > my_emails_file.txt
grep -i -E '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$' *.txt

###############################
#### Text Editing - Imogen ####
###############################

# SED
# Most common: substitution
# sed [options] ‘s/REGEX/REPLACEMENT/[FLAGS]’  file
# sed [options] ‘s/foo/bar/[FLAGS]’  file
#	Flags: g = global, [1:9] = number match,  p = print
# Removal of lines
# sed [options] ‘1,3d’
# Printing lines
# sed -n 5, 30p

# Try this -
echo 'abc' | sed 's/abc/xyz/'
# And what is this one doing?
echo 'abc' | sed 's/./xyz/g'
# we can apply that to our previously generated shuffled file
cat ../my-big-file | sed 's/1/a/' | head -n 25

#AWK on tabulated data, printing sums or certain columns
printf 'fish\n%.0s' {1..20} > my_meals.txt ; printf 'meat\n%.0s' {1..20} >> my_meals.txt ; printf 'veggies\n%.0s' {1..20} >> my_meals.txt # creates a file of randome text strings
head -n 60 ../my-big-file > my_nbs.txt ; paste my_meals.txt my_nbs.txt > my_meals_nbs.txt
cat my_meals_nbs.txt

# awk '
# 	BEGIN { actions } 
# 	/pattern/ { actions }
#               …….
#	 END { actions } 
# ' filenames

awk -F  '\t'  '$1 ~ /fish/ {sum += $2} END {print sum}'  my_meals_nbs.txt
awk -F  '\t'  '$1 ~ /^fish$/ {sum += $2} END {print sum}'  my_meals_nbs.txt
awk -F '\t'  '$1 == "veggies" {sum += $2} END {print sum}'  my_meals_nbs.txt
awk -F '\t'  '$1 != "fish" {sum += $2} END {print sum}'  my_meals_nbs.txt

#SPLIT up file by number of lines (-l) or bytes (-b)
# split [options] filename prefix


## TEXT EDITOR PRACTISE 2
mkdir exercise2 ; cd exercise2 	#making directory and file
echo 1 2 1 > exercise2.txt
echo 1 2 3 >> exercise2.txt
echo 1 1 1 >> exercise2.txt
head exercise2.txt #looking at file
sed -i  's/1/4/2' exercise2.txt	#changing the second instance of “1” to “4”
awk -F" " '{print $0, "the sum is "$1+$2+$3}' exercise2.txt > exercise2_sum.txt  #summing and creating new column
split -l 1 -d --additional-suffix .txt exercise2_sum.txt exercise2_ 
cat exerci*.txt
ls #splitting the output file into separate numbered files

##########################################
#### Conditional Statements and Loops ####
##########################################
cd ~/work/bash_slurm_training/bash/morning_tutorial_3/

# 1. conditional statement
# given two varaibles with $1 being age and $2 being yes || no having a note from parents
age=11 ; note="no"
if [ $1 > 18 ]
  then
    echo You may go to the party.
  elif [ $note == 'yes' ]
  then
    echo You may go to the party but be back before midnight.
  else
    echo You may not go to the party.
fi
# try changing the conditions 

# let's use a file's data to run a loop and call a function iteratively for each of the line of this file
cat my_meals_nbs.txt | head | cut -f 1 | while read meal 
do 
    echo $meal
    echo "run my script for the meal $meal"
done

# same with 2 variables
cat my_meals_nbs.txt | head | while read meal codebar
do 
    echo "run my script for the meal $meal considering the barcode $codebar"
done

# simple loop for which numbers are stated
for i in 1 2 3 4 5
do
   echo "Welcome $i times"
done

# or in a continuous sequence of integers
for i in {0..10}
  do 
     echo "Welcome $i times"
 done

## TEXT EDITOR PRACTISE III
cd ~/work/bash_slurm_training/bash/morning_tutorial_3/exercise2
wget https://raw.githubusercontent.com/Imogen-D/Bases_De_Bash_Workshop/main/exercise2script.awk 
ls #check your file is there
less exercise2script.awk  #whats in the file? press 'q' to quit
chmod +x exercise2script.awk #make the script executable
./exercise2script.awk exercise2_02.txt #run the script

