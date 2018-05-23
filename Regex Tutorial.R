Species = c('petiolata','verticillatus','salicicaria','minor')

# grep() function will find occurences 

grep("a", Species)

#grepl() is like grep() but returns TRUE/FALSE
grepl("a",Species)

#sub() replaces the first match in each element
sub("a","A",Species)

#gsub() replaces the all the matches in each element
gsub("a","A",Species)

# WILDCARDS
#wildcards are placeholder variables that can mean a variety of things 
#Many wildcards use the escape character: \
#Often in R you need two escape characters: \\

Phrase = "...which 1-100 words get replaced?"

# \\w represents any alpha numeric character

gsub("\\w",'*', Phrase)
sub("\\w",'*', Phrase)

# \\W is the inverse of \\w (all non alphanumeric characters)

# \\s is space
# \\t is tab
# \\d is digits
# \\D is non digits

# Two special characters are \\r and \\n

SampleText = "Line 0 \n\r Line 1 \n Line 2"
write(SampleText, "SampleText.txt")

# We can use "or" characters: | 
gsub("a|e","*",Species)

#A special wildcard is .
# . means any character

gsub(".","", Phrase)

#Use * for 'any number of occurences'
#Use + for 'one or more number of occurences'
#Use {} for 'a certain number of occurences'

sub(".","*",Phrase)

sub(".*","X",Phrase)

sub(".{3}","X",Phrase)
# * is a greedy search 

sub("\\W*\\w* \\w.\\w*","X",Phrase)

sub("\\w+","X", Phrase)

# ? is a lazy search
sub(".?","X",Phrase)


#Find n to m matches using {n,m}

gsub("\\w{4,}","X", Phrase)

Mat = c('A1','C1','E1','J1','S11','T13')

# List a range of options with []
gsub('[acth]','X',Phrase)

# ^ searches at the start of the line 
# $ searches at the end of the line 
sub('\\?$', 'X',Phrase)
sub('^w','X',Phrase)

# Capture text with () and save with \\1 \\2 etc
sub('(\\W+\\w+\\s)(\\d+)(-)(\\d+)(\\s.*)','\\1\\4\\3\\2\\5',Phrase)

# Exercise
Mat1 = gsub('[AC]\\d+', 'North', Mat)
Mat2 = gsub('[EJ]\\d+','Mid',Mat1)
Mat3 = gsub('[S-T]\\d+','South',Mat2)
print (Mat3)










