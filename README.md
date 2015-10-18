README:

Currently this program will take in the name of a file via a command line argument
and output the tests cases that you actually want run.

to run a test file:

ruby main.rb filename

to create a test file, the first line must be the command that is to be used
as the base test command. Following an empty line, the rest of the lines should
be a series of comma seperated values to be used in the test command.

For example:

testCase1.txt:

python foobar($1,$2,$3,fnc($4)) == $5  
   
1,2,3,4,5
1,1,1,1,1
0,9,9,4,1

then if one runs 

ruby main.rb testCase1.txt

the program will generate a set of cases to be run and executed, and therefore
used as tests, with each of the values in the comma seperated values section
respectively replacing the dollar sign lead variable names in the command.
