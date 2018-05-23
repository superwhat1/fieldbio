#Functions in R have a name followed by brackets
# abs(2/3)
#log(10) is 2.3 because its natural
#?log() ask questions
1 %in% c(1,2,3)
1 %in% c(1:10)  

# R uses objects/ types
x="hello"
y=123
z=1.23
Day= "Monday"
# A 'vector' object is a group of values 
c(1:10) #vector of integers
c(x,y,z,Day)#vector of strings 
Group = c(x,y,z) #vector object
Numbers = c(1:10)
print(Numbers)
print(x,Numbers)
paste(x,Numbers)#cycles through vector numbers and outputs concatenated strings for each
paste("Day:",Group, y,Numbers ) #cycles through each vector, repeats shorter one
PasteOut=paste("Day:",Group, y,Numbers)
PasteOut[4]
#Matrix object is n*n size 
Xmat = matrix(1:100, nrow=10)
Xmat[7,8] #pull element from matrix
t(Xmat)

Ymat = matrix(1:100,ncol=5,byrow=TRUE)
print(Ymat)

#Vector and Matrix math
Numbers*10 #multiply each element in vector
Xmat*2 #multiply each elementin matrix

Numbers *Xmat #

Numbers %*% Xmat