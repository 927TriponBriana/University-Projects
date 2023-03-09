class Controller:
    def __init__(self, repo):
        self.__repo = repo

    def print_board(self):
        return self.__repo.create_board()

    def get_data_from_board(self):
        return self.__repo.get_data()

    def move(self, row, col, symbol):
        self.__repo.move(row, col, symbol)

    def find_empty_replace(self, symbol):
        self.__repo.find_empty_and_replace(symbol)

    def replace(self, row, col, row2, col2, symbol):
        try:
            self.__repo.replace(row, col, row2, col2, symbol)
        except ValueError as ve:
            return ValueError(ve)

    def move_from_square_to_another(self, symbol):
        row, col = self.__repo.find_o(symbol)
        row2, col2 = self.__repo.find_empty_square()
        self.__repo.replace(row, col, row2, col2, symbol)

    def won_game(self):
        return self.__repo.won_game()

    def dont_let_win(self, symbol):
        self.__repo.dont_let_win_move(symbol)
