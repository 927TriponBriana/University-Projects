from tkinter import *
from tkinter import messagebox
from SixSixBoard import SixSIxBoard


class GameGUI:
    def __init__(self, ai):
        self.__ai = ai
        self.tk = Tk()
        self.tk.geometry("600x400+0+0")
        self.tk.title("Obstruction")

        all_frames = Frame(self.tk)
        all_frames.pack()

        self.frames = {}


        for frame in (StartGame, SixSIxBoard):
            fr = frame(all_frames, self, self.__ai)
            self.frames[frame] = fr
            fr.grid(row=0, column=0, sticky="nsew")
        self.show_frame(StartGame)

        self.tk.mainloop()

    def show_frame(self, name):
        """Function which will show the current frame the user is on"""
        frame = name
        name = self.frames[name]
        if frame != StartGame:
            name.create_board()
            result = messagebox.askyesno("?", "Do you want to be the one who starts the game?")
            if result is not True:
                name.first_ai()
        name.tkraise()

    def quit_frame(self):
        self.show_frame(StartGame)


class StartGame(Frame):
    def __init__(self, parent, controller, nothing):
        Frame.__init__(self, parent)
        self.game = ""
        self.__ctr = controller

        # Creating the title
        lblInfo = Label(self, font=('terminal', 20, 'bold'), text="The Obstruction game", fg="steel blue", bd=20,
                        anchor='w')
        lblInfo.grid(row=0, column=0)

        # adding a fill label to put a space between title and the next widgets
        fill_label = Label(self)
        fill_label.grid(row=1)

        # Creating the radio buttons and the buttons for the game
        lbl = Label(self, font=('terminal', 10), text="Grid sizes:", bd=1, anchor='e', fg="steel blue")
        lbl.grid(row=1, column=0)
        self.set(SixSIxBoard)

        # 3 radio buttons, one for each grid size
        radio_six = Radiobutton(self, text="6x6 Grid", value=1, command=lambda: self.set(SixSIxBoard))
        radio_six.deselect()
        radio_six.grid(row=2)

        # the buttons for start, description and quit
        self.start = Button(self, text="Start", bg="light green", height=2, width=10, command=lambda: self.start_game())
        self.start.grid(row=6)
        self.desc = Button(self, text="Description", width=10, height=2, bg="cyan", command=lambda: self.description())
        self.desc.grid(row=7)
        self.ButtonQuit = Button(self, background="#DA2C43", text="Quit", height=2, width=10, command=lambda: Frame.quit(self))
        self.ButtonQuit.grid(row=8)

    def set(self, game_frame):
        self.game = game_frame

    @staticmethod
    def description():
        messagebox.showinfo("Description", "One player is 'O' and the computer is 'X'. Players take turns in writing their "
                                           "symbol in a cell. The restriction is that you can only play in a cell if all its "
                                           "neighbours are empty.The first player unable to move loses.")

    def start_game(self):
        self.__ctr.show_frame(self.game)
