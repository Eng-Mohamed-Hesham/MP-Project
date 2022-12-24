# Team Members:
  1- Kariem Alaa El-dien .\
  2- Mohamed Mamdouh Salah .\
  3- Michael Mettry Kamel .\
  4- Mostafa Mahmoud Mohamed .\
  5- Mohamed Hesham .\

# Under the supervision of:
  Dr. Abdelhamid Attaby.\
  Eng. Mahmoud Taha. \

# MP-Project
## Classroom Grading System.
Student system to handle grading mechanism in classroom for efficient service. \
system can store no more then (85) student grades .\

## System Mechanism 
First system need to store students grades then make some fundamental operations:- \

1- System begin to load all students gardes and save it in program data. \
2- Recieve user requests to add or edit grade of a given ID. \
3- Recieve user requests to search for grade by ID. \
4- Recieve user requests to display the list of grades.\
5- Recieve user requests to delete student.\
6- Then repeat until user ask no more requests.\
7- After exiting program, data is saved in a file so it can be accessed again. \
    
### Loading Data from external storage
* first program begin to open datafile (Grades.txt) in read mode. \
* then loop over grades of students and set every grade to it's student id .\
* so after loading operation system become able to perform other operation. \

### Adding / Editing Student Grade by Id
* first you have to enter grade to set it to some id entered by user .\
* program begin to get id and grade and set that grade to this id .\
  so it update this grade if this id has previous grade and set a new grade if there no student here.\ 

### Searching for Student Grade by Id
* first you have to enter student id .\
* program do it's calculations to get grade stored for this student .\
* print student with id and print required grade .\

### Displaying All Grades
* program begin to load students grades data .\
* step by step program begin to check grade for each student .\
* if grade equal zero then no action performed .\
* if there valid grade then print it's id and it's grade .\
* repeat these step until reach end of grades .\

### Deleting Student Grade by Id
* first you have to enter student id then system get it .\
* second get grade of this student id and set it to zero
* print "Deleted Successfully to user"

### Saving Data to external storage
* first program get handle of external file(Grades.txt) and open it in write mode .\
* loop over program data and set grade of every id for given position on file .\
* finally data is stored successfully in Sequential form then program exited safely .\

#### Thanks
