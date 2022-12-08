#include <stdio.h>
#include <stdlib.h>

struct student_info
{
    unsigned short Id;
    unsigned short marks;
};
unsigned short number_of_students = 0;
struct student_info arr_of_students[1000];
unsigned short i;

void show_grades(struct student_info in[1000]);
void bubbleSort_using_IDS(struct student_info arr[1000], int n);
void bubbleSort_using_Marks(struct student_info arr[1000], int n);
void swap(struct student_info *s1, struct student_info *s2);
unsigned short Binary_Search_Using_Id(struct student_info arr[1000], int n);

void main(void)
{
    printf("Enter the number of students(DOES NOT EXCEED 1000): ");
    scanf("%hu", &number_of_students);
    for (i = 0; i < number_of_students; i++)
    { // putting id and mark into the array of struct!
        printf("Enter the ID of student[%hu]: ", i + 1);
        scanf("%hu", &arr_of_students[i].Id);
        printf("Enter the mark of student[%hu]: ", i + 1);
        scanf("%hu", &arr_of_students[i].marks);
    }
    printf("*******************Stored Marks***********************\n");
    label:
        printf("choose (1) to show your list of students:\nchoose (2) to sort the list using Ids of students:\nchoose (3) to sort the list using Marks of students:\nchoose (4) to Search about Student:\nAnother to exit:\n");
        unsigned int choose;
        scanf("%u", &choose);
        switch (choose)
        {
        case 1:
            show_grades(arr_of_students);
            goto label;
            break;
        case 2:
            bubbleSort_using_IDS(arr_of_students, number_of_students);
            goto label;
            break;
        case 3:
            bubbleSort_using_Marks(arr_of_students, number_of_students);
            goto label;
            break;
        case 4:
            Binary_Search_Using_Id(arr_of_students, number_of_students);
            goto label;
            break;
        case 5:
            return;
            break;
        default:
            break;
        }
}

void show_grades(struct student_info arr[1000])
{
    for (i = 0; i < number_of_students; i++)
    { // print students info
        printf("student[%hu] id is %hu and mark is %hu \n", i + 1, arr[i].Id, arr[i].marks);
    }
}

void bubbleSort_using_IDS(struct student_info arr[1000], int n)
{
    int i, j;
    for (i = 0; i < n - 1; i++)
    {
        for (j = 0; j < n - i - 1; j++)
        {
            if (arr[j].Id > arr[j + 1].Id)
                swap(&arr[j], &arr[j + 1]);
        }
    }
}

void bubbleSort_using_Marks(struct student_info arr[1000], int n)
{
    int i, j;
    for (i = 0; i < n - 1; i++)
    {
        for (j = 0; j < n - i - 1; j++)
        {
            if (arr[j].Id > arr[j + 1].Id)
                swap(&arr[j], &arr[j + 1]);
        }
    }
}

void swap(struct student_info *s1, struct student_info *s2)
{
    struct student_info temp = *s1;
    (*s1) = (*s2);
    *s2 = temp;
}
unsigned short Binary_Search_Using_Id(struct student_info arr[1000], int n){
    printf("Enter Student's ID:");
    int x;  scanf("%d", &x);
    bubbleSort_using_IDS(arr, n);
    int l = 0, r = n-1, ans = -1;
    while (l <= r){
        int mid = (l+r) >> 1;
        if(arr[mid].Id == x){
            ans = arr[mid].marks;
            break;
        }   
        else if(arr[mid].Id > x)    r = mid - 1;
        else    l = mid + 1;
    }
    if(ans != -1) printf("Student's ID: %d and his Mark: %hu\n", x, ans);
    else    printf("No Student found with this ID %d\n", x);
}
unsigned short Binary_Search_Using_Id(struct student_info arr[1000], int n){
    printf("Enter Student's ID:");
    int x;  scanf("%d", &x);
    bubbleSort_using_IDS(arr, n);
    int l = 0, r = n-1, ans = -1;
    while (l <= r){
        int mid = (l+r) >> 1;
        if(arr[mid].Id == x){
            ans = arr[mid].marks;
            break;
        }   
        else if(arr[mid].Id > x)    r = mid - 1;
        else    l = mid + 1;
    }
    if(ans != -1) printf("Student's ID: %d and his Mark: %hu\n", x, ans);
    else    printf("No Student found with this ID %d\n", x);
}


