#include <check.h>               
#include "libft.h"        
#include <string.h>

START_TEST(test_my_memset) {
  char my_memset_string[10] = "0123456789"; 
  char memset_string[10] = "0123456789"; 

  my_memset_string[9] = '\0';
  memset_string[9] = '\0';

  my_memset(my_memset_string, 'c', 9);
  memset(memset_string, 'c', 9);
  ck_assert_str_eq(my_memset_string, memset_string);
} END_TEST


Suite *my_memset_suite(void) {
  Suite *s;
  TCase *tc_core;

  s = suite_create("My memset");
  tc_core = tcase_create("Core");

  tcase_add_test(tc_core, test_my_memset);
  suite_add_tcase(s, tc_core);

  return s;
}

