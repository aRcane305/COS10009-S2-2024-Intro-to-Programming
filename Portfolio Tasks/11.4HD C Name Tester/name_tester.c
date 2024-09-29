// standard C libraries
#include <stdio.h>
#include <string.h>
// custom library for managing user inputs (like input_functions)
#include "terminal_user_input.h"

#define LOOP_COUNT 60

void print_silly_name(my_string name)
{
  int i;

  printf(" %s is a", name.str); // space before %s to fix output formatting,
  i = 0;
  while (i < LOOP_COUNT)
  {
    printf("  silly"); // double space as requirement
    i = i + 1;
  }
  printf("\nname!"); // prints name! on new line (\n inside, different to ruby)
}

int main()
{
  // defined in line 25 - 28 of terminal_user_input.h
  my_string name;

  // storing the user input as an array called name
  name = read_string("What is your name? ");
  printf("\nYour name");

  // name.str basically is Saad is stored in the array, we can proceed
  if (strcmp(name.str, "Saad") == 0)
  {
    printf(" is an AWESOME name!");
  } else
  {
    print_silly_name(name);
  }

  return 0;
}
