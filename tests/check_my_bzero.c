#include <check.h>               
#include "libft.h"        
#include <string.h>
#include <stdio.h>

START_TEST(test_my_bzero) {
  char my_bzero_string[10] = "0123456789"; 
  char bzero_string[10] = "0123456789"; 

  my_bzero_string[9] = '\0';
  bzero_string[9] = '\0';

  my_bzero(my_bzero_string, 9);
  bzero(bzero_string, 9);

  printf("%s\n%s", my_bzero_string, bzero_string);
  ck_assert_str_eq(my_bzero_string, bzero_string);
} END_TEST


Suite *my_bzero_suite(void) {
  Suite *s;
  TCase *tc_core;

  s = suite_create("My bzero");
  tc_core = tcase_create("Core");

  tcase_add_test(tc_core, test_my_bzero);
  suite_add_tcase(s, tc_core);

  return s;
}

