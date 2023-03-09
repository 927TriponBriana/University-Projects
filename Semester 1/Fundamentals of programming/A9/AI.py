from board import ValidatePoint
from point import Point
from random import randint


class AIController:
    def __init__(self, board):
        self.__board = board
        self.__valid = ValidatePoint()
        self.__startodd = False  # Variable which tells us if AI is the first to make a move on an odd board

    def get_board(self):
        return self.__board

    def set_row(self, row):
        self.__board.set_row(row)

    def set_column(self, column):
        self.__board.set_column(column)

    def create_board(self):
        self.__board.create_board()
        self.__startodd = False

    def destroy_board(self):
        self.__board.destroy_board()

    def make_move_player(self, x, y):
        """Function that validates the move the player wants to make."""
        self.__valid.valid_point(x, y, self.__board)
        point = Point(x, y)
        self.__board.get_board()[point.get_x()][point.get_y()] = 1
        self.__board.board_move(point)

    def _check_odd(self, x, y):
        """Function that returns true if the board has an odd size and false otherwise"""
        return x % 2 and y % 2

    def _get_mirror(self, x, y):
        """Function that returns a Point that represents the mirrored move of the player, strategy used by AI when
        it is the one to make the first move on an odd board"""
        row = self.__board.get_row()
        col = self.__board.get_column()

        if self.__board.get_board()[row - x - 1][col - y - 1] == 0:
            return Point(row - x - 1, col - y - 1)

        if self.__board.get_board()[x][col - y - 1] == 0:
            return Point(x, col - y - 1)

        if self.__board.get_board()[row - x - 1][y] == 0:
            return Point(row - x - 1, y)

    def _decide_move(self, computer, row, column, moves):
        """Function that decides how will the AI make its next move based on some criteria"""

        # If the AI starts we check if the board has odd coordinates
        if computer is True and len(moves) == row * column:
            if self._check_odd(row, column):
                return 1

        if self.__startodd is True and len(moves) != row * column:
            return 1

        # If the above criteria wasn't met, the AI will just make its move randomly
        return 2

    def _first_odd(self, row, column, moves, x, y):
        """ If the board is odd and AI makes the first move, then the first move will be in the center of the board.
        In order to win, next the AI will only mirror the player's moves."""

        # If it is the first move, AI takes the central square
        if len(moves) == row * column:
            row_x = row // 2
            column_y = column // 2
            self.__board.get_board()[int(row_x)][int(column_y)] = 2
            move = Point(row_x, column_y)
            self.__board.board_move(move)
            self.__startodd = True
            return move

        # If the board is odd and AI started, it will mirror the player's move in order to win
        if len(moves) != row * column:
            move = self._get_mirror(int(x), int(y))
            self.__board.get_board()[int(move.get_x())][int(move.get_y())] = 2
            self.__board.board_move(move)
            return move

    def _random_move(self, moves):
        move = randint(0, len(moves) - 1)
        self.__board.get_board()[moves[move].get_x()][moves[move].get_y()] = 2
        self.__board.board_move(moves[move])
        return moves[move]

    def make_move_ai(self, computer, x, y):
        moves = self.__board.available_move()
        row = self.__board.get_row()
        column = self.__board.get_column()
        next_move = self._decide_move(computer, row, column, moves)

        if next_move == 1:
            return self._first_odd(row, column, moves, x, y)
        elif next_move == 2:
            # If the above criteria wasn't met, the AI will just make its move randomly
            return self._random_move(moves)

    def game_over(self):
        if self.__board.available_move():
            return True
        return False
