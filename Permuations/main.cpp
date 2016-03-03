
/*
*	Permutations - Takes an array of characters and the substring length of give
*	substring permutations of the input length.
*
*	@author - Rachit Nigam (rachit.nigam12@gmail.com)
*	
*	Note : Implementation of stacks and queues is very specific and should not
*	be used as modules for any other program.
*/

#include"iostream"
#include<stdlib.h>
#include<stdio.h>
#include<string.h>

//Default size of the string
int const size=40;

/*	Push the given element into the stack
*
*	Takes three parametes
*
*	@param stack the array which is the stack implementation
*	@param top the index of stack array pointing to the top
*	@param charToPush the character to be pushed in the stack
*
*	@return 0 for failure to push	
*	@return 1 for success to push	
*/
int push(char stack[],int &top,char charToPush)
{
 if(top==size-1)
 	return 0;
 else
 {
	stack[++top]=charToPush;
  	return 1;
 }
}

//Pop the stack and return the element
char pop(char stack[],int &top)
{
	//If 
	if(top==-1)
 		return 0;
	
	else
	{
 		int indexToReturn=top;
 		top--;
 		return stack[indexToReturn];
 	}
}

//To check if the given stacks are equal(1) or not(0)
int check_stack(char stack1[],int top1,char stack2[],int top2)
{
	if(top1!=top2) return 0;
	int isEqual=1;
	for(int i=0;i<=top1;i++)
	{
		if(stack1[i]!=stack2[i])
			isEqual=0;
	}
 return isEqual;
}

//Function to display the give stack
void display(char stack[],int &top)
{
 for(int i=0;i<=top;i++)
  std::cout<<stack[i];
}

//Function to return and remove the first member of the queue
char qdelete(char queue[],int &rear)
{
	char charToReturn;
	if(rear==-1)
		return 0;
	else
	{
		if(!rear)
		{
			charToReturn=queue[0];
			rear=-1;
			return charToReturn;
		}
		else
		{
			charToReturn=queue[0];
			for(int i=0;i<rear;i++)
				queue[i]=queue[i+1];
			rear--;
			return charToReturn;
		}
	}
}

void permute(char disp[],int &dispTop,char temp[],int &tempRear,char check[size][size],int checkTop[],int c,int n=0)
{
	//Static variable to count the number of outputs
 int static count=0;
 //Display condition
 if(n==c)
 {
   display(disp,dispTop);
   count++;
   //------------------------Display formater--------------
   if(count%(80/(c+1))==0) std::cout<<endl;
   else std::cout<<" ";
   //------------------------------------------------------
   //Pop element twice and insert into temp
   push(temp,tempRear,pop(disp,dispTop));
   //Return the function
   return;
 }

 //Create check for nth level
 for(int i=0;i<=tempRear;i++)
	 check[n][i]=temp[i];
 checkTop[n]=tempRear;
 //push element into disp from temp
 push(disp,dispTop,qdelete(temp,tempRear));
	//Recursive call
	permute(disp,dispTop,temp,tempRear,check,checkTop,c,n+1);

 //Exit condition
 do
 {
	 if(check_stack(temp,tempRear,check[n],checkTop[n]))
	 {
	 	//if temp and check are equal, all the permutations
	 	//of this level of recursion are done
	 	//pop from disp and push into temp
		 push(temp,tempRear,pop(disp,dispTop));
		 //Return the function
		 return;
	 }
	 else
	 {
	 	//if temp and check are not equal, all the permutations
	 	//of this level of recursion are not yet done
	 	//push the front element of temp into disp
		 push(disp,dispTop,qdelete(temp,tempRear));
		 //Recursive call
		 permute(disp,dispTop,temp,tempRear,check,checkTop,c,n+1);
	 }
	}while(1);
}

int main()
{
 char disp[size],temp[size],check[size][size];
 int dispTop=-1,tempRear=-1,checkTop[size],n;
 for(int i=0;i<size;i++)
	checkTop[i]=-1;
 std::cout<<"Enter the string:";
 gets(temp);
 tempRear=strlen(temp)-1;
 std::cout<<"Enter the length of the substring:";
 std::cin>>n;

 //Catch condition
 if( !(n<=strlen(temp) && n>0) ) 
  n=strlen(temp);

 permute(disp,dispTop,temp,tempRear,check,checkTop,n);
 std::cout<<"\n";
 return 0;
}
