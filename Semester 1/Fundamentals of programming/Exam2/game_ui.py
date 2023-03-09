class UI:
    def __init__(self, controller):
        self.__controller = controller

    def start(self):
        nr = 0
        nr_o = 0
        option = input("Choose piece to play with (X or O): ")
        if option == "X":
            computer = "O"
        elif option == "O":
            computer = "X"
        while True:
            ok = 0
            print(self.__controller.print_board())
            if nr < 4 and nr_o < 4:
                print("Choose a square to place: ")
                row = int(input("Enter row: "))
                col = int(input("Enter column: "))
                try:
                    self.__controller.move(row, col, option)
                    print(self.__controller.print_board())
                    nr += 1
                    nr_o += 1
                    ok = 1
                    if self.__controller.won_game() is True:
                        print("You won!")
                        return
                except ValueError as ve:
                    print(ve)
                if ok == 1 and nr == 1 and nr_o == 1:
                    self.__controller.find_empty_replace(computer)
                    # nr_o += 1
                    if self.__controller.won_game() is True:
                        print("You lost!")
                        return
                elif ok == 1 and nr > 1 and nr_o > 1:
                    try:
                        self.__controller.dont_let_win(option)
                        # nr_o += 1
                        if self.__controller.won_game() is True:
                            print("You lost!")
                            print(self.__controller.print_board())
                            break
                    except ValueError:
                        self.__controller.find_empty_replace(computer)
            if nr == 4 and nr_o == 4:
                print("Choose a square to move from: ")
                valid = 0
                while valid == 0:
                    row = int(input("Enter the row: "))
                    col = int(input("Enter the column: "))
                    if row < 3 and col < 3 and row >= 0 and col >= 0:
                        valid = 1
                    else:
                        print("Invalid input!")
                print("Choose a square where to be moved : ")
                valid = 0
                while valid == 0:
                    row2 = int(input("Enter the row: "))
                    col2 = int(input("Enter the column: "))
                    if row < 3 and col < 3 and row >= 0 and col >= 0:
                        valid = 1
                    else:
                        print("Invalid input!")
                try:
                    self.__controller.replace(row, col, row2, col2, option)
                    print(self.__controller.print_board())
                    if self.__controller.won_game() is True:
                        print("You won!")
                        break
                    ok = 1
                except ValueError as ve:
                    print(ve)
                if ok == 1:
                    self.__controller.move_from_square_to_another(computer)
                    if self.__controller.won_game() is True:
                        print("You lost!")
                        print(self.__controller.print_board())
                        break
                    ok = 0

