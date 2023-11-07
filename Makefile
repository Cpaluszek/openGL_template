#########################
#		VARIABLES		#
#########################
NAME			:= openGL_template

HEADERS_DIR		:= inc
HEADERS_FILES	:= Shader.h
#Shader.h \ Camera.h \ stb_image.h

HEADERS			:= $(addprefix $(HEADERS_DIR)/, $(HEADERS_FILES))

SRC_DIR			:=	src
SRC_FILES		:=	main.cpp \
					Shader.cpp
#					Camera.cpp \
#					stb_image.cpp

SRCS			:= $(addprefix $(SRC_DIR)/, $(SRC_FILES))

BUILD_DIR		:=	build
OBJS			:=	$(SRC_FILES:%.cpp=$(BUILD_DIR)/%.o)

CC				:=	g++
DEBUG_FLAG		:=	-g3 -D DEBUG

CC_FLAGS		:= -Wextra -Werror -Wall -std=c++17
CC_LINKS		:= -L./lib
CC_LIBS			:= -lglfw -lGLEW -lGL -ldl -lX11 -lpthread -lXrandr -lXi

CC_HEADERS		:= -I./lib/GLFW/include


#########################
# 		RULES			#
#########################
all: $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CC_FLAGS) $(CC_HEADERS) $(CC_LINKS) $(OBJS) $(CC_LIBS) -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp Makefile $(HEADERS)
	@mkdir -p $(@D)
	$(CC) $(CC_FLAGS) $(CC_HEADERS) -c $< -o $@

echo:
	@echo $(OBJS)
	@echo $(SRCS)

lint:
	cpplint --linelength=120 --filter=-legal/copyright --exclude=inc/stb_image.h $(SRCS) $(HEADERS)

clean:
	@rm -rf $(BUILD_DIR)

fclean: clean
	@rm -rf $(NAME)

re: fclean all

.PHONY: all clean fclean re lint