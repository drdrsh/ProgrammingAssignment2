# Author:
#   Mostafa Abdelraouf <mostafa.mohmmed@gmail.com>
# Description:
#   Peer assessment assignment (Programming Assignment 2) submission
#   for JHU R programming course
#   https://class.coursera.org/rprog-016/human_grading/view/courses/973757/assessments/3/submissions
#  
# Notes:
#   1) I have strayed a bit from the requirements of the assignment for sake
#   of encapsulation and to not clutter the global namespace.
#   I have encapsulated the function that caches the inverse matrix inside the 
#   returned object. The user of this object will not be required to explicitly call "cacheSolve".
#   Instead, if the user needs to get the inverse matrix he will just have to call
#   GetInverse(), it will calculate and cache the result and any further calls will be
#   served the cached inverse directly.
#  2) This file uses, to the best of my ability, Google's R Style guide
#   http://google-styleguide.googlecode.com/svn/trunk/Rguide.xml 

makeCacheMatrix <- function(x=matrix()) {
  # Creates a matrix object that supports inverse matrix calculation and caching 
  #
  # Args:
  #	x: A matrix to build the object around,note that the matrix is assumed
  #		to be invertable.
  #
  # Returns:
  #	A list of functions (Or rather, an object) that can be used to modify
  #	the matrix

 
  # Check if the x parameter is a matrix, if not, prints an error 
  # message and exits
  if (!is.matrix(x)){
    message("Parameter supplied to makeMatrix() MUST be a matrix")
    return (NULL)
  }

  original.matrix <- x
  inverse.matrix <- NULL	# This will hold our inverse matrix
 
  Set <- function(x) {
    # Sets the value of the internal matrix and invalidates the cache.
    #
    # Args:
    #	x: A matrix to build the object around,note that the matrix is assumed
    #		to be invertable.
    #
    # Returns:
    #	True on success, false of failure

    # if y is not a matrix, we output an error message and make no changes to
    # the internal matrix
    if (!is.matrix(x)){
      message("Parameter supplied to Set() MUST be a matrix")
      return (FALSE)
    }
  
    original.matrix <<- x # change the value of the internal matrix to "y"
    
    # Notice that when resetting the internal matrix we invalidated any previously 
    # stored "inverse" by setting it to null
    inverse.matrix <<- NULL
    
    message("Resetting internal matrix, cache is now invalid")
    
    TRUE
  }

  Get <- function(){
    # Gets the internal matrix
    #
    # Returns:
    #	a copy of the internal matrix
    original.matrix
  }

  GetInverse <- function(){
    #	Calculates, caches and returns the inverse matrix of the internal matrix using (solve() function)
    #
    # Returns:
    #	the inverse matrix of the internal matrix using (solve() function) 
    
    # Check to see if we have a valid "inverse matrix" cache for our matrix
    # if so, return it immediately 
    if (!is.null(inverse.matrix)){
      message("Returning cache")
      return(inverse.matrix)
    }
    
    # Otherwise, generate the inverse cache and store it internally in the "inverse.matrix" variable
    message("No cache found, generating cache")
    inverse.matrix <<- solve(original.matrix)
    
    #return the inverse
    inverse.matrix
    
  }

  # This will return a list containing 3 functions that can be used to manipulate this particular
  # instance of the matrix
  list(
    Set = Set, 
    Get = Get,
    GetInverse = GetInverse
  )
  
}

cacheSolve <- function(x){
  #	This function is here to comply with the assignment requirements, it merely wraps around GetInverse() function
  #
  # Args:
  #	x: A matrix object created with makeCacheMatrix
  #
  # Returns:
  #	the inverse matrix x 
  
  x$GetInverse()
}