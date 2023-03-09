from game import Board
from game_controller import Controller


class Test:
    board = Board()
    controller = Controller(board)
    controller.move(1, 1, 'X')
    assert board.get_data() == [[' ', ' ', ' '], [' ', 'X', ' '], [' ', ' ', ' ']]
    controller.move(2, 2, 'O')
    assert board.get_data() == [[' ', ' ', ' '], [' ', 'X', ' '], [' ', ' ', 'O']]
    controller.move(0, 1, 'O')
    assert board.get_data() == [[' ', 'O', ' '], [' ', 'X', ' '], [' ', ' ', 'O']]
    controller.replace(1, 1, 0, 0, 'X')
    assert board.get_data() == [['X', 'O', ' '], [' ', ' ', ' '], [' ', ' ', 'O']]
