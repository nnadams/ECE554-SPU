#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "data.h"

#define MAX_STR_LEN 256000

const char * file1 = "string_a.txt";
const char * file2 = "string_b.txt";

char *A;
char *B;

void readStringFile(const char *file, char *dst, int max){
	FILE *fp;
	int c; 
	int count; 
	
    fp = fopen(file, "r");
	count = 0; 
	if(fp == NULL) 
    {
      perror("Error in opening file");
      return;
    }
    do
    {
       c = fgetc(fp);
       if( feof(fp) )
       {
            break;
       }
       else if(c == '\n') {}
	   else if(count == max){
		    *dst = '\0';
			break;
	   }
	   else{
		    *dst++ = (char)c;
		    count++; 
	   }
    }while(1);
}

int main(){
	int res; 
	int lenA; 
	int lenB; 
	int i; 
	clock_t begin;
	printf("Hello World... Timing String Comapre\n");

	A = malloc(MAX_STR_LEN * sizeof(char));
	B = malloc(MAX_STR_LEN * sizeof(char));
	
	if (!A || !B){
		printf("malloc error");
		return 1;
	}
	
	readStringFile(file1, A, MAX_STR_LEN);
	readStringFile(file2, B, MAX_STR_LEN);
	
	begin = clock();
	
	lenA = strlen(A);
	lenB = strlen(B);	
	printf("String Lengths: A: %d B: %d\n", lenA, lenB);
	
	//for (i = 0; i < 1000000; i++){
		res = strcmp(A, B);
		printf("strcmp Result: %d\n", res);
	//}
	
	clock_t end = clock();
	double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	printf("Elasped: %f\n", time_spent);
	return 0;
}