#include<stdio.h>
int suma(int, int, int); // procedura din asamblare

int main(void)
{
	printf("Introduceti 3 numere: a,b,c: ");
	printf("\n");
	
    int a,b,c;
    scanf("%d",&a);
    scanf("%d",&b);
    scanf("%d",&c);
    
    int sum = suma (a,b,c);
    
	printf("a+b-c= ");
    printf("%d",sum);
    return 0;
}