from point import Point


class Board:
    def __init__(self, row=0, column=0):
        self.__row = row
        self.__column = column
        self.__board = []

    def get_row(self):
        return self.__row

    def get_column(self):
        return self.__column

    def set_row(self, row):
        self.__row = row

    def set_column(self, column):
        self.__column = column

    def available_move(self):
        move = []
        for coordinate_x in range(self.get_row()):
            for coordinate_y in range(self.get_column()):
                if self.__board[coordinate_x][coordinate_y] == 0:
                    move.append(Point(coordinate_x, coordinate_y))
        return move

    def board_move(self, point):
        """Function that borders all the existing neighbours of a point, if they exist and they are not bordered
        already"""
        coordinate_x = point.get_x()
        coordinate_y = point.get_y()
        if coordinate_x - 1 >= 0 and coordinate_y - 1 >= 0 and self.__board[coordinate_x - 1][coordinate_y - 1] == 0:
            self.__board[coordinate_x - 1][coordinate_y - 1] = -1
        if coordinate_x - 1 >= 0 and self.__board[coordinate_x - 1][coordinate_y] == 0:
            self.__board[coordinate_x - 1][coordinate_y] = -1
        if coordinate_x - 1 >= 0 and coordinate_y + 1 < self.__column and self.__board[coordinate_x - 1][coordinate_y + 1] == 0:
            self.__board[coordinate_x - 1][coordinate_y + 1] = -1
        if coordinate_y - 1 >= 0 and self.__board[coordinate_x][coordinate_y - 1] == 0:
            self.__board[coordinate_x][coordinate_y - 1] = -1
        if coordinate_y + 1 < self.__column and self.__board[coordinate_x][coordinate_y + 1] == 0:
            self.__board[coordinate_x][coordinate_y + 1] = -1
        if coordinate_x + 1 < self.__row and coordinate_y + 1 < self.__column and self.__board[coordinate_x + 1][coordinate_y + 1] == 0:
            self.__board[coordinate_x + 1][coordinate_y + 1] = -1
        if coordinate_x + 1 < self.__row and self.__board[coordinate_x + 1][coordinate_y] == 0:
            self.__board[coordinate_x + 1][coordinate_y] = -1
        if coordinate_x + 1 < self.__row and coordinate_y - 1 >= 0 and self.__board[coordinate_x + 1][coordinate_y - 1] == 0:
            self.__board[coordinate_x + 1][coordinate_y - 1] = -1

    def __len__(self):
        return len(self.__board)

    def __str__(self):
        string = "\n   "
        for coordinate_y in range(self.__column):
            string += str(coordinate_y) + '   '
        for coordinate_x in range(self.__row):
            string += "\n "
            string += "-" * (4 * self.__column + 1)
            string += "\n"
            string += str(coordinate_x) + '|'
            for coordinate_y in range(self.__column):
                if self.__board[coordinate_x][coordinate_y] == 1:  # 1 = the player
                    string += ' ' + '0' + ' ' + "|"
                elif self.__board[coordinate_x][coordinate_y] == 2:  # 2 = the computer
                    string += ' ' + 'X' + ' ' + "|"
                elif self.__board[coordinate_x][coordinate_y] == -1:
                    string += '|||' + "|"
                else:
                    string += ' ' + ' ' + ' ' + "|"
        string += "\n "
        string += "-" * (4 * self.__column + 1) + "\n"
        return string

    def get_board(self):
        return self.__board

    def create_board(self):
        """ The board will be a list of lists, each list will represent a row, and each element of these lists will
        represent a column.
        """
        for coordinate_x in range(self.__row):
            array = []
            for coordinate_y in range(self.__column):
                array.append(0)
            self.__board.append(array)

    def destroy_board(self):
        self.__board = []
        self.__row = 0
        self.__column = 0


class ValidatePoint:
    @staticmethod
    def valid_point(coordinate_x, coordinate_y, board):
        """Function that validates the coordinates of a point given"""
        try:
            coordinate_x = int(coordinate_x)
            coordinate_y = int(coordinate_y)
        except ValueError:
            raise Exception("Please give integers!")
        if coordinate_y < 0 or coordinate_x < 0 or coordinate_y >= board.get_column() or coordinate_x >= board.get_row():
            raise Exception("Point out of border!")
        if board.get_board()[coordinate_x][coordinate_y] == -1 or board.get_board()[coordinate_x][coordinate_y] == 1 or board.get_board()[coordinate_x][coordinate_y] == 2:
            raise Exception("Square already taken!")
