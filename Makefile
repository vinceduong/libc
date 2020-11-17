NAME = libft.a
CC = gcc
FLAGS = -Wall -Wextra -Werror
SRC = $(wildcard src/*.c)
OBJ = $(SRC:.c=.o)

$(OBJ): src/%.o: src/%.c
	$(CC) -c $(FLAGS) -Iinc -o $@ $<

$(NAME): $(OBJ) 
	ar r $(NAME) $(OBJ)
	ranlib $(NAME)

all: $(NAME)

.PHONY: clean
clean:
	/bin/rm -rf $(OBJ)

.PHONY: fclean
fclean: clean
	/bin/rm -rf $(NAME)

re: fclean all
