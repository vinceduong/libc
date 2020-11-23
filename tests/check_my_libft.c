#include <check.h>               
#include "libft.h"        
#include <stdlib.h>

Suite *my_memset_suite(void);
Suite *my_bzero_suite(void);

int main(void) {
  int no_failed = 0;

  SRunner *runner = srunner_create(my_memset_suite());
  srunner_add_suite(runner, my_bzero_suite());

  srunner_run_all(runner, CK_NORMAL);
  no_failed = srunner_ntests_failed(runner);
  srunner_free(runner);
  return (no_failed == 0) ? EXIT_SUCCESS : EXIT_FAILURE;  
}
