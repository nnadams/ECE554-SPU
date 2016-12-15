#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX_STR_LEN 140000

const char * file1 = "../pc_spart/string1.txt";
const char * file2 = "../pc_spart/string2.txt";

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

int main(int argc, char *argv[] ){
	int ret_val;
    char *p_retval;
	int i; 
	clock_t begin;
    int cmd;
    char imm; 
    
    if (argc > 3 || argc == 1){
        printf("Incorrect number of args\n");
        return 1;
    }
    cmd = atoi(argv[1]);
    
    if(cmd >= 4 && cmd <= 9 && argc == 2){
        printf("Need immediate for that cmd.\n");
        return 1;
    }
    
    if (argc == 3){
        imm = argv[2][0];
    }
    
	printf("Hello World... Timing String Op\n");

	A = malloc(MAX_STR_LEN * sizeof(char));
	B = malloc(MAX_STR_LEN * sizeof(char));
	
	if (!A || !B){
		printf("malloc error");
		return 1;
	}
	
	readStringFile(file1, A, MAX_STR_LEN);
	readStringFile(file2, B, MAX_STR_LEN);
	
	begin = clock();
	switch (cmd){
        case 0:
        case 1:
            ret_val = strlen(A);
            break;
        case 2:
        case 3:
            ret_val = strcmp(A, B);
            break;
        case 4:
        case 5:
            p_retval = strchr(A, imm);
            ret_val = (int)(p_retval - A);
            break;
        case 6:
        case 7:
            p_retval = strrchr(A, imm);
            ret_val = (int)(p_retval - A);
            break;
        case 8:
        case 9:
            for (i=0; A[i]; A[i]==imm ? i++ : *A++);
            ret_val = i;
            break;
        case 10:
        case 11:
            p_retval = strstr(A, B);
            ret_val = (int)(p_retval - A);
            break;
    }

	clock_t end = clock();
	double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	printf("Elasped: %f\n", time_spent);
    printf("Return Val: %d\n", ret_val);
	return 0;
}