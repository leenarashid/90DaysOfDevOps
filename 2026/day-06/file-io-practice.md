###File Creation: I created a file with touch command,touch my_file.txt


###Writing text to the file: Added the contents with cat > my_file.txt command


###Appending the file: Appended the file with cat >> my_file.txt command.


###File Reading: Read the file,now displaying the complete content with cat my_file.txt command.

###echo "Line 1" > my_file.txt: Writes the text Line 1 into a file named my_file.txt, creating it if it doesn’t exist

or overwriting it if it does.

####echo "Line 2" >> my_file.txt:Appends the text Line 2 to the end of my_file.txt without overwriting existing content.

###echo "Line 3" | tee -a notes.txt:Adds Line 3 to the end of my_file.txt and also displays it on the terminal at the same time.

###head -n 2 notes.txt: Displays the first 2 lines of the file.

###tail -n 2 notes.txt: Displays the last 2 lines of the file.
