
from operator import itemgetter

from service.undo_redo_service import FunctionCall, Operation
from domain.entities import Grade
from domain.validators import GradeValidatorException
from util.util import Util

class GradeService(object):
    def __init__(self, grade_repository, student_repository, discipline_repository, undoController):
        self.__grade_repository = grade_repository
        self.__student_repository = student_repository
        self.__discipline_repository = discipline_repository
        self.__undoController = undoController

    def checkExistentIdInRepository(self, grade, student_repository, discipline_repository):
        errors = []
        if not int(grade.studentID) in student_repository.get_all_id():  errors.append("Invalid student!")
        if not int(grade.disciplineID) in discipline_repository.get_all_id(): errors.append("Invalid discipline!")
        if len(errors) > 0:
            raise GradeValidatorException(errors)

    def addGrade(self, disciplineID, studentID, gradeValue):
        grade = Grade(disciplineID, studentID, gradeValue)
        self.checkExistentIdInRepository(grade, self.__student_repository, self.__discipline_repository)
        self.__grade_repository.save(grade)

        redo = FunctionCall(self.addGrade, disciplineID, studentID, gradeValue)
        undo = FunctionCall(self.removeGrade, disciplineID, studentID, gradeValue)
        operation = Operation(redo, undo)
        self.__undoController.recordOperation(operation)


    def removeGrade(self, disciplineID, studentID, gradeValue):
        for grade in self.get_all_grade():
            if grade.disciplineID == disciplineID and grade.studentID == studentID and grade.grade_value == gradeValue:
                self.__grade_repository.delete(grade.entity_ID)


    def get_all_grade(self):
        return self.__grade_repository.get_all()


    def add_removed(self, lst):
        for entity in lst:
            self.addGrade(entity.disciplineID, entity.studentID, entity.grade_value)

    def remove_by_studentID(self, studentID):
        list_of_grades = self.get_all_grade()
        list_of_removed_students = []
        for student in list_of_grades:
            if int(student.studentID) == int(studentID):
                self.__grade_repository.delete(student.entity_ID)
                list_of_removed_students.append(student)

        redo = FunctionCall(self.remove_by_studentID, studentID)
        undo = FunctionCall(self.add_removed, list_of_removed_students)
        operation = Operation(redo, undo)
        self.__undoController.recordOperation(operation)


    def remove_by_disciplineID(self, disciplineID):
        list_of_grades = self.get_all_grade()
        list_of_removed_disciplines = []
        for discipline in list_of_grades:
            if int(discipline.disciplineID) == int(disciplineID):
                self.__grade_repository.delete(discipline.entity_ID)
                list_of_removed_disciplines.append(discipline)

        redo = FunctionCall(self.remove_by_studentID, disciplineID)
        undo = FunctionCall(self.add_removed, list_of_removed_disciplines)
        operation = Operation(redo, undo)
        self.__undoController.recordOperation(operation)


    def getStudentsAtDiscipline(self, discipline_id):
        list_of_students = {}
        for i in self.__grade_repository.get_all():
            if i.disciplineID == discipline_id:
                if i.studentID not in list_of_students:
                    list_of_students[i.studentID] = round(float(i.grade_value), 3)
                else:
                    list_of_students[i.studentID] = round(float((float(list_of_students[i.studentID]) + float(i.grade_value)) / 2), 3)
        return list_of_students

    @staticmethod
    def calculateAverage(dict, solution):
        for element in dict:
            if element not in solution:
                solution[element] = float(dict[element])
            else:
                solution[element] = round(float((float(solution[element]) + float(dict[element])) / 2), 3)
        return solution

    def getFallenStudents(self):
        fallen_students = {}
        for discipline in self.__discipline_repository.get_all_id():
            list_of_students = self.getStudentsAtDiscipline(discipline)
            for student in list_of_students:
                if float(list_of_students[student]) < 5:
                    fallen_students[student] = round(0.0, 3)
        return fallen_students

    def getBestStudents(self):
        best_students = {}
        for id in self.__discipline_repository.get_all_id():
            best_students = GradeService.calculateAverage(self.getStudentsAtDiscipline(id), best_students)
        return best_students

    def getBestDisciplines(self):
        best_disciplines = {}
        for id in self.__discipline_repository.get_all_id():
            if len(self.getStudentsAtDiscipline(id)) == 0:
                best_disciplines[id] = float(0)
                continue
            list_average = {}
            list_average = GradeService.calculateAverage(self.getStudentsAtDiscipline(id), list_average)
            average = 0
            best_disciplines[id] = round(float(sum((list_average[discipline_average] for discipline_average in list_average if id not in best_disciplines), float(average)) / len(list_average) ), 3)
        return best_disciplines

    def statisticBestStudents(self):
        #return Util.sort(list(self.getBestStudents().items()), key=itemgetter(1), reverse=True, algorithm=Algorithm.gnome_sort)
        return sorted(self.getBestStudents().items(), key=itemgetter(1), reverse=True)

    def statisticBestDisciplines(self):
        #return Util.sort(list(self.getBestDisciplines().items()), key=itemgetter(1), reverse=True, algorithm=Algorithm.teleport_gnome_sort)
        return sorted(self.getBestDisciplines().items(), key=itemgetter(1), reverse=True)
