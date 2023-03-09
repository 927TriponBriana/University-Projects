from game import Board
from game_controller import Controller
from game_ui import UI

board = Board()
controller = Controller(board)
ui = UI(controller)

ui.start()
