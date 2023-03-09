from board import Board
from AI import AIController
from console import Console
from GUI import GameGUI

game = AIController(Board())


ui = Console(game)
ui.start()

# ui = GameGUI(game)