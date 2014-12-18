# Author:
#   Mostafa Abdelraouf <mostafa.mohmmed@gmail.com>
# Description:
#   Output of the Peer assessment assignment (Programming Assignment 2) submission
#   for JHU R programming course
#   https://class.coursera.org/rprog-016/human_grading/view/courses/973757/assessments/3/submissions
#

source('cachematrix.R');

a <- c(100,50,90)
b <- c(200,42,99)
c <- c(77,56,34)

d <- c(105,33,80)
e <- c(240,22,59)
f <- c(78,33,39)

# Create our matrix
m1 <- makeCacheMatrix(rbind(a,b,c))
message("Original Matrix")
print(m1$Get())

# This call will not find a cached matrix and thus will generate it
message("Inverted Matrix")
print(m1$GetInverse())

# All subsequent calls to "getInverse" will use the cached inverse matrix
print(m1$GetInverse())
print(m1$GetInverse())
print(m1$GetInverse())

# The following call will change the matrix and invalidate the cache
m1$Set(rbind(d,e,f))
message("Original Matrix")
print(m1$Get())

# This call will not find a cached matrix and thus will generate it
message("Inverted Matrix")
print(m1$GetInverse())

# All subsequent calls to "getInverse" will use the cached matrix
print(m1$GetInverse())
print(m1$GetInverse())
print(m1$GetInverse())
