#COLORS
RESET = \033[0m
RED = \033[31m
GREEN = \033[32m
YELLOW = \033[33m

NAME = libft.a
CC = gcc
FLAGS = -Wall -Wextra -Werror
COVRFLAGS = -fprofile-arcs -ftest-coverage
SRCDIR = src
OBJDIR = obj
INCDIR = inc
TESTSDIR = tests
SRC = $(wildcard $(SRCDIR)/*.c)
OBJ = $(patsubst $(SRCDIR)/%, $(OBJDIR)/%, $(SRC:.c=.o))
TESTS = $(wildcard $(TESTSDIR)/*.c)
TESTSOBJ = $(patsubst $(TESTSDIR)/%, $(OBJDIR)/%, $(TESTS:.c=.o))
TESTSCOVREPORT = $(OBJ:.o = .gcna)
TESTSCOVOBJECTS = $(OBJ:.o = .gcno)
TESTSNAME = check_libft
COVRDIR = covr
COVR = $(COVRDIR)/coverage_report.html

#MESSAGES
building_objects:
	@echo "$(YELLOW)>Building object files...$(RESET)"

object_files_created:
	@echo "$(GREEN)>Object files created!\n$(RESET)"

building_library:
	@echo "$(YELLOW)>Building $(NAME)...\n$(RESET)"

building_tests:
	@echo "$(YELLOW)>Building tests...$(RESET)"

#RULES

$(OBJ): $(OBJDIR)/%.o: $(SRCDIR)/%.c $(OBJDIR)
	@echo "$(YELLOW)>>Compiling file... \t$<$(RESET)"
	@$(CC) $(FLAGS) $(COVRFLAGS) -I$(INCDIR) -c -o $@ $<
	@echo "$(GREEN)>>Created object file \t$@"

$(OBJDIR):
	@echo "$(YELLOW)>>Creating ./$@ directory... \t$(RESET)"
	@mkdir $@
	@echo "$(GREEN)>>Created ./$@ directory! \t$(RESET)"

$(TESTSOBJ): $(OBJDIR)/%.o: $(TESTSDIR)/%.c
	@echo "$(YELLOW)>>Compiling test file... \t$<$(RESET)"
	@$(CC) $(FLAGS) $(COVRFLAGS) -I$(INCDIR) -c -o $@ $<
	@echo "$(GREEN)>>Created object file \t\t$@"

$(NAME): building_library building_objects $(OBJ) object_files_created
	@ar r $(NAME) $(OBJ)
	@ranlib $(NAME)
	@echo "$(GREEN)>$(NAME) created !$(RESET)"

.DEFAULT_GOAL := all
all: $(NAME) 

clean_coverage:
	rm *.gcno *.gcda

$(COVRDIR):
	@echo "$(YELLOW)>>Creating ./$@ directory... \t$(RESET)"
	@mkdir $@
	@echo "$(GREEN)>>Created ./$@ directory! \t\t$(RESET)"

.PHONY: tests
tests: $(SRC) $(TESTS) $(COVRDIR) clean_covr
	@$(CC) $(SRC) $(TESTS) $(FLAGS) $(COVRFLAGS) -I$(INCDIR) -lcheck -o $(TESTSNAME) 
	@echo "$(GREEN)>Tests created !$(RESET)"
	@echo "$(YELLOW)>Running tests...$(RESET)"
	@./$(TESTSNAME)
	@echo "$(YELLOW)>Generating coverage report...$(RESET)"
	@gcovr -r . --html --html-details -o $(COVR) 
	@echo "$(GREEN)>Generated coverage report at $(COVR) !$(RESET)"

clean_covr:
	@echo "$(RED)>Removing coverage files... $(RESET)"
	@/bin/rm -rf $(COVRDIR)/*
	@echo "$(GREEN)>Coverage files removed!\n$(RESET)"

.PHONY: clean
clean:
	@echo "$(RED)>Removing object files... $(RESET)"
	@/bin/rm -rf $(OBJDIR)/* $(TESTSCOVOBJ) $(TESTSCOVREPORT) *.gcda *.gcno
	@echo "$(GREEN)>Object files removed!\n$(RESET)"

.PHONY: fclean
fclean: clean
	@echo "$(RED)>Removing $(NAME)...$(RESET)"
	@/bin/rm -rf $(NAME) $(TESTSNAME)
	@echo "$(GREEN)>$(NAME) $(TESTSNAME) removed !\n$(RESET)"


re: fclean all
