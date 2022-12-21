#include <stdio.h>
#include <stdlib.h>
void show_grades(unsigned short arr[]);
unsigned short number_of_students = 0;
unsigned short arr_of_students[1000];
unsigned short x;

void main(void)
{
    printf("Enter the number of students(DOES NOT EXCEED 1000): ");
    scanf("%hu", &number_of_students);
    for (int i = 1; i <= number_of_students; i++)
    {
        printf("Enter the ID of student[%hu]: ", i);
        scanf("%hu", &x);
        printf("Enter the mark of student[%hu]: ", i);
        scanf("%hu", &arr_of_students[x]);
    }
    printf("*******************Stored Marks***********************\n");
label:
    printf("choose (1) to show your list of students:\nchoose (2) to show grade of student using Id of student:\nchoose (3) to add Mark for student:\nchoose (4) to modify grade of student:\nchoose another to exit:\n");
    unsigned int choose;
    scanf("%u", &choose);
    switch (choose)
    {
    case 1:
        show_grades(arr_of_students);
        goto label;
        break;
    case 2:
        show_mark_for_one_student(arr_of_students);
        goto label;
        break;
    case 3:
        Add_Student(arr_of_students);
        goto label;
        break;
    case 4:
        modify_mark(arr_of_students);
        goto label;
        break;
    case 5:
        delet_student(arr_of_students);
        goto label;
        break;
    case 6:
        return;
        break;
    default:
        break;
    }
}

void show_grades(unsigned short arr[])
{
    for (int i = 1; i <= number_of_students; i++)
    {
        if(arr[i] != -1)    printf("student[%hu] id is %hu \t mark is %hu \n", i, i, arr[i]);
    }
    printf("**************************************************\n");
}

void show_mark_for_one_student(unsigned short arr[])
{
    printf("Enter the ID of student to show: \n");
    scanf("%d", &x);
    if(arr[x])    printf("student id is %hu and his mark is %hu \n", x, arr[x]);
    else    printf("No grade for this student.\n");
    printf("*******************Stored Marks***********************\n");
}

void delet_student (unsigned short arr[])
{
    printf("Enter the ID of student you want to delete: \n");
    scanf("%d", &x);
    arr[x] = 0;
    for (int i = x; i <= number_of_students-2; i++)
    {
        arr[x] = arr[x+1];
    }
    number_of_students--;
        printf("*******************student with id [%hu] has been Deleted!***********************\n", x);

}

void modify_mark(unsigned short arr[])
{
    int y;
    printf("Enter the ID of student to show: \n");
    scanf("%d", &x);
    if(arr[x] != x)
    {
        unsigned short temp = arr[x];
        printf("Enter the new grade of student to modify: \n");
        scanf("%d", &y);
        arr[x] = y;
        printf("old grade is %hu and new grade is %hu \n", temp, arr[x]);
    }
    else    printf("No grade for this student.\n");
}

void Add_Student(unsigned short arr[])
{
    printf("Enter the ID of student to Add: \n");
    scanf("%d", &x);
    if(arr[x])
    {
        printf("There is a grade for this student\n");
    }
    else
    {
        int y;
        printf("Enter the grade for this student.\n");
        scanf("%d", &y);
        arr[x] = y;
        printf("The grade is added for this student.\n");
    }
}

