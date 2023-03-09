
class Console(object):
    def __init__(self, student_controller, discipline_controller, grade_controller, undoController):
        self.__student_controller = student_controller
        self.__discipline_controller = discipline_controller
        self.__grade_controller = grade_controller
        self.__undoController = undoController

    def printOptions(self):
        print(
            "\n0. Exit\n1. Add student\n2. Add discipline\n3. Add grade\n4. List students\n5. List discipline\n6. List grades\n"
            "7. Remove student\n8. Remove discipline\n9. Update student\n10. Update discipline\n11. Search students\n"
            "12. Search disciplines\n13. Statistics\n14. Undo last operation\n15. Redo last operation\n")

    def printStudent(self, student):
        print("Student ID: ", student.entity_ID, " Name: ", student.name)

    def uiPrintStudents(self, args):
        list_of_students = self.__student_controller.get_all_students()
        for student in list_of_students:
            self.printStudent(student)

    def printOptionsAttributes(self, attributes):
        list_of_arguments = []
        for i in attributes:
            print(i, end="")
            parameter = input()
            list_of_arguments.append(parameter)
        return list_of_arguments

    def printDiscipline(self, discipline):
        print("Discipline ID: ", discipline.entity_ID, " Name: ", discipline.name)

    def uiPrintDisciplines(self, args):
        list_of_disciplines = self.__discipline_controller.get_all_discipline()
        for discipline in list_of_disciplines:
            self.printDiscipline(discipline)

    def printGrade(self, grade):
        print("Discipline ID: ", grade.disciplineID, " Student ID: ", grade.studentID, " Grade value: ", grade.grade_value)

    def uiPrintGrades(self, args):
        list_of_grades = self.__grade_controller.get_all_grade()
        for grade in list_of_grades:
            self.printGrade(grade)

    def uiRemoveStudent(self, student):
        try:
            student[0] = int(student[0])
        except ValueError:
            print("Try a natural number")
            return
        self.__student_controller.removeStudent(student[0])
        self.__grade_controller.remove_by_studentID(student[0])

    def uiRemoveDiscipline(self, discipline):
        try:
            discipline[0] = int(discipline[0])
        except ValueError:
            print("Try a natural number")
            return
        self.__discipline_controller.removeDiscipline(discipline[0])
        self.__grade_controller.remove_by_disciplineID(discipline[0])

    def uiSearchStudents(self, student):
        found_students = self.__student_controller.searchStudents(student)
        if found_students == None or found_students == []:
            print("No student found!")
        else:
            if type(found_students) == type([]):
                for students in found_students:
                    self.printStudent(students)
            else:
                self.printStudent(found_students)

    def uiSearchDisciplines(self, discipline):
        found_discipline = self.__discipline_controller.searchDisciplines(discipline)
        if found_discipline == None or found_discipline == []:
            print("No discipline found!")
        else:
            if type(found_discipline) == type([]):
                for disciplines in found_discipline:
                    self.printDiscipline(disciplines)
            else:
                self.printDiscipline(found_discipline)


    def uiShowStatistics(self, command):
        if command[0] == "1":
            fallen_students = self.__grade_controller.getFallenStudents()
            for student in fallen_students:
                print(self.__student_controller.searchByID(student).name)
        elif command[0] == "2":
            best_students = self.__grade_controller.statisticBestStudents()
            for student in range(0, len(best_students)):
                if self.__student_controller.searchByID(best_students[student][0]) == None:
                    continue
                print(self.__student_controller.searchByID(best_students[student][0]).name, " ", best_students[student][1])
        elif command[0] == "3":
            best_disciplines = self.__grade_controller.statisticBestDisciplines()
            for discipline in range(0, len(best_disciplines)):
                print(self.__discipline_controller.searchByID(best_disciplines[discipline][0]).name, " ", best_disciplines[discipline][1])
        else:
            raise ValueError("Incorrect statistic")


    def uiUndoOperation(self, args):
        self.__undoController.undo()


    def uiRedoOperation(self, args):
        self.__undoController.redo()


    def uiAddStudent(self, student):
        try:
            student[0] = int(student[0])
        except ValueError:
            print("Try a natural number!")
            return
        self.__student_controller.addStudent(student[0], student[1])

    def uiAddDiscipline(self, discipline):
        try:
            discipline[0] = int(discipline[0])
        except ValueError:
            print("Try a natural number!")
            return
        self.__discipline_controller.addDiscipline(discipline[0], discipline[1])

    def uiAddGrade(self, grade):
        try:
            grade[0] = int(grade[0])
            grade[1] = int(grade[1])
            grade[2] = float(grade[2])
        except ValueError:
            print("Try a natural number")
            return
        self.__grade_controller.addGrade(grade[0], grade[1], grade[2])

    def uiUpdateStudent(self, student):
        try:
            student[0] = int(student[0])
        except ValueError:
            print("Try a natural number")
            return
        self.__student_controller.updateStudent(student[0], student[1])

    def uiUpdateDiscipline(self, discipline):
        try:
            discipline[0] = int(discipline[0])
        except ValueError:
            print("Try a natural number")
            return
        self.__discipline_controller.updateDiscipline(discipline[0], discipline[1])


    def menuBasedRead(self):
        options = {"1": self.uiAddStudent, "2": self.uiAddDiscipline,
                   "3": self.uiAddGrade, "4": self.uiPrintStudents, "5": self.uiPrintDisciplines,
                   "6": self.uiPrintGrades, "7": self.uiRemoveStudent, "8": self.uiRemoveDiscipline,
                   "9": self.uiUpdateStudent, "10": self.uiUpdateDiscipline,
                   "11": self.uiSearchStudents, "12": self.uiSearchDisciplines, "13": self.uiShowStatistics,
                   "14":self.uiUndoOperation, "15":self.uiRedoOperation}
        attributes = {"1": ["studentID: ", "name: "], "2": ["disciplineID: ", "name: "],
                      "3": ["disciplineID: ", "studentID: ", "grade_value: "],
                      "4": [], "5": [], "6": [], "7": ["studentID: "], "8": ["disciplineID: "],
                      "9": ["studentID: ", "name: "], "10": ["disciplineID: ", "name: "], "11": ["studentID/name: "],
                      "12": ["disciplineID/title: "],
                      "13": [
                          "1.All students failing at one or more disciplines\n2.Students with the best school situation\n3.Sort all disciplines by average\n"],
                      "14":[], "15":[]}

        while True:
            try:
                self.printOptions()
                cmd = input()
                if cmd == "0":
                    break
                if cmd not in options.keys():
                    raise ValueError("Inexistent command")
                args = self.printOptionsAttributes(attributes[cmd])

                if str(cmd) == "1" or str(cmd) == "2" or str(cmd) == "3" or str(cmd) == "7" or str(cmd) == "9" or str(cmd) == "8" or str(cmd) == "10":
                    self.__undoController.newOperation()


                options[cmd](args)
            except Exception as ex:
                print(ex)


    def runApp(self):
        self.menuBasedRead()
