from texttable import *


class Board:
    def __init__(self):
        self.__data = [[" "] * 3 for i in range(3)]

    def create_board(self):
        board = Texttable()
        for index in range(3):
            board.add_row(self.__data[index])
        return board.draw()

    def set_data(self, new_data):
        self.__data = new_data

    def get_data(self):
        return self.__data

    def move(self, row, col, symbol):
        """
        this function places a piece on an unoccupied square
        :param row: the given row
        :param col: the given column
        :param symbol: the symbol to be put on the given square from the given row and column
        """
        if row < 0 or row > 2 or col < 0 or col > 2:
            raise ValueError("Invalid row/column!")
        if self.__data[row][col] == ' ':
            self.__data[row][col] = symbol
        else:
            raise ValueError("The square is already occupied!")

    def replace(self, row, col, row2, col2, symbol):
        """
        this function moves the symbol that occupies the square (row, col) into an empty square (row2, col2)
        :param row:
        :param col:
        :param roe2:
        :param col2:
        :return:
        """
        if self.__data[row][col] == symbol and self.__data[row2][col2] == ' ':
            self.__data[row2][col2] = symbol
            self.__data[row][col] = ' '
        else:
            raise ValueError("Impossible move!")

    # def replace_o(self, row, col, row2, col2):
    #     """
    #     this function moves the piece X that occupies the square (row, col) intro an empty square (row2, col2)
    #     :param row:
    #     :param col:
    #     :param row2:
    #     :param col2:
    #     :return:
    #     """
    #     if self.__data[row][col] == 'O' and self.__data[row2][col2] == ' ' and ((row == row2 or row == row2 - 1 or row == row2 + 1) and (col == col2 or col == col2 - 1 or col == col2 + 1)):
    #         self.__data[row2][col2] = 'O'
    #         self.__data[row][col] = ' '
    #     else:
    #         raise ValueError("Impossible move!")

    def find_empty_and_replace_with_o(self):
        ok = 0
        for index_row in range(0, 3):
            for index_col in range(0, 3):
                if self.__data[index_row][index_col] == ' ':
                    self.__data[index_row][index_col] = 'O'
                    ok = 1
                if ok == 1:
                    ok = 2
                    break
            if ok == 2:
                break

    def find_empty_and_replace_with_x(self):
        ok = 0
        for index_row in range(0, 3):
            for index_col in range(0, 3):
                if self.__data[index_row][index_col] == ' ':
                    self.__data[index_row][index_col] = 'X'
                    ok = 1
                if ok == 1:
                    ok = 2
                    break
            if ok == 2:
                break

    def find_empty_and_replace(self, symbol):
        ok = 0
        for index_row in range(0, 3):
            for index_col in range(0, 3):
                if self.__data[index_row][index_col] == ' ':
                    self.__data[index_row][index_col] = symbol
                    ok = 1
                if ok == 1:
                    ok = 2
                    break
            if ok == 2:
                break

    def find_empty_square(self):
        for index_row in range(0, 3):
            for index_col in range(0, 3):
                if self.__data[index_row][index_col] == ' ':
                    return index_row, index_col

    def find_o(self, symbol):
        for index_row in range(0, 3):
            for index_col in range(0, 3):
                if self.__data[index_row][index_col] == symbol:
                    return index_row, index_col

    def won_game(self):
        if self.__data[0] == ['X', 'X', 'X'] or self.__data[0] == ['O', 'O', 'O']:
            return True
        elif self.__data[1] == ['X', 'X', 'X'] or self.__data[0] == ['O', 'O', 'O']:
            return True
        elif self.__data[2] == ['X', 'X', 'X'] or self.__data[0] == ['O', 'O', 'O']:
            return True
        elif self.__data[0][0] == 'X' and self.__data[1][1] == 'X' and self.__data[2][2] == 'X':
            return True
        elif self.__data[0][0] == 'O' and self.__data[1][1] == 'O' and self.__data[2][2] == 'O':
            return True
        elif self.__data[0][2] == 'X' and self.__data[1][1] == 'X' and self.__data[2][0] == 'X':
            return True
        elif self.__data[0][2] == 'O' and self.__data[1][1] == 'O' and self.__data[2][0] == 'O':
            return True
        elif self.__data[0][0] == 'X' and self.__data[0][1] == 'X' and self.__data[0][2] == 'X':
            return True
        elif self.__data[0][0] == 'O' and self.__data[0][1] == 'O' and self.__data[0][2] == 'O':
            return True
        elif self.__data[1][0] == 'X' and self.__data[1][1] == 'X' and self.__data[1][2] == 'X':
            return True
        elif self.__data[1][0] == 'O' and self.__data[1][1] == 'O' and self.__data[1][2] == 'O':
            return True
        elif self.__data[2][0] == 'X' and self.__data[2][1] == 'X' and self.__data[2][2] == 'X':
            return True
        elif self.__data[2][0] == 'O' and self.__data[2][1] == 'O' and self.__data[2][2] == 'O':
            return True

    def dont_let_win_move(self, symbol):
        ok = 0
        if symbol == 'X':
            other_symbol = 'O'
        if symbol == 'O':
            other_symbol = 'X'
        for i in range(0, 3):
            if self.__data[i] == [symbol, symbol, ' ']:
                self.__data[i] = [symbol, symbol, other_symbol]
                ok = 1
            elif self.__data[i] == [' ', symbol, symbol]:
                self.__data[i] = [other_symbol, symbol, symbol]
                ok = 1
            elif self.__data[i] == [symbol, ' ', symbol]:
                self.__data[i] = [symbol, other_symbol, symbol]
                ok = 1
        if ok == 0:
            if self.__data[0][0] == symbol and self.__data[1][1] == symbol and self.__data[2][2] == ' ':
                self.__data[2][2] = other_symbol
                ok = 1
            elif self.__data[0][0] == symbol and self.__data[1][1] == ' ' and self.__data[2][2] == symbol:
                self.__data[2][2] = other_symbol
                ok = 1
            elif self.__data[0][0] == ' ' and self.__data[1][1] == symbol and self.__data[2][2] == symbol:
                self.__data[2][2] = other_symbol
                ok = 1
            elif self.__data[0][2] == symbol and self.__data[1][1] == symbol and self.__data[2][0] == ' ':
                self.__data[2][0] = other_symbol
                ok = 1
            elif self.__data[0][2] == symbol and self.__data[1][1] == ' ' and self.__data[2][0] == symbol:
                self.__data[1][1] = other_symbol
                ok = 1
            elif self.__data[0][2] == ' ' and self.__data[1][1] == symbol and self.__data[2][0] == symbol:
                self.__data[0][2] = other_symbol
                ok = 1
            elif self.__data[0][0] == ' ' and self.__data[1][0] == symbol and self.__data[2][0] == symbol:
                self.__data[0][0] = other_symbol
                ok = 1
            elif self.__data[0][0] == symbol and self.__data[1][0] == ' ' and self.__data[2][0] == symbol:
                self.__data[1][0] = other_symbol
                ok = 1
            elif self.__data[0][0] == symbol and self.__data[1][0] == symbol and self.__data[2][0] == ' ':
                self.__data[2][0] = other_symbol
                ok = 1
            elif self.__data[0][1] == ' ' and self.__data[1][1] == symbol and self.__data[2][1] == symbol:
                self.__data[0][1] = other_symbol
                ok = 1
            elif self.__data[0][1] == symbol and self.__data[1][1] == ' ' and self.__data[2][1] == symbol:
                self.__data[1][1] = other_symbol
                ok = 1
            elif self.__data[0][1] == symbol and self.__data[1][1] == symbol and self.__data[2][1] == ' ':
                self.__data[2][1] = other_symbol
                ok = 1
            elif self.__data[0][2] == symbol and self.__data[1][2] == symbol and self.__data[2][2] == ' ':
                self.__data[2][2] = other_symbol
                ok = 1
            elif self.__data[0][2] == symbol and self.__data[1][2] == symbol and self.__data[2][2] == ' ':
                self.__data[0][2] = other_symbol
                ok = 1
            elif self.__data[0][2] == symbol and self.__data[1][2] == ' ' and self.__data[2][2] == symbol:
                self.__data[1][2] = other_symbol
                ok = 1
            elif self.__data[0][2] == ' ' and self.__data[1][2] == symbol and self.__data[2][2] == symbol:
                self.__data[0][2] = other_symbol
                ok = 1
            if ok == 0:
                ok = 0
                for i in range(0, 3):
                    for j in range(0, 3):
                        if self.__data[i][j] == ' ':
                            self.__data[i][j] = other_symbol
                            ok = 1
                        if ok == 1:
                            ok = 2
                            break
                    if ok == 2:
                        break





# def test_create_table():
#     board = Board()
#     board.create_board()
#     return board
#
#
# print(test_create_table())

