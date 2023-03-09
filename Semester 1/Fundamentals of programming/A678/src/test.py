from unittest import TestCase

from src.domain.validators import StudentValidator, StudentValidatorException
from src.domain.validators import DisciplineValidator, DisciplineValidatorException
from src.domain.validators import GradeValidator, GradeValidatorException
from src.domain.entities import Student, Discipline, Grade
from src.service.student_service import StudentService, DisciplineService, GradeService
from src.repository.repository import Repository

class TestStudentValidator(TestCase):
    def test_validate__invalid_student_id__raiseException(self):
        student1 = Student('v', "Maria")
        self.assertRaises(StudentValidatorException, StudentValidator.validate, student1)
        student2 = Student(" ", "Maria")
        self.assertRaises(StudentValidatorException, StudentValidator.validate, student2)

    def test_validate__invalid_student_name__raiseException(self):
        student1 = Student("1", "123")
        self.assertRaises(StudentValidatorException, StudentValidator.validate, student1)
        student2 = Student("1", " ")
        self.assertRaises(StudentValidatorException, StudentValidator.validate, student2)

class TestDisciplineValidator(TestCase):
    def test_validate__invalid_discipline_id__raiseException(self):
        discipline1 = Discipline(" ", "FP")
        self.assertRaises(DisciplineValidatorException, DisciplineValidator.validate, discipline1)
        discipline2 = Discipline("d", "FP")
        self.assertRaises(DisciplineValidatorException, DisciplineValidator.validate, discipline2)

    def test_validate__invalid_discipline_name__raiseException(self):
        discipline1 = Discipline("1", "14")
        self.assertRaises(DisciplineValidatorException, DisciplineValidator.validate, discipline1)
        discipline2 = Discipline("1", " ")
        self.assertRaises(DisciplineValidatorException, DisciplineValidator.validate, discipline2)

class TestGradeVlaidator(TestCase):
    def test_validate__invalid_grade__raiseException(self):
        grade1 = Grade("1", "1", "asd")
        self.assertRaises(GradeValidatorException, GradeValidator.validate, grade1)
        grade2 = Grade("1", "1", "14")
        self.assertRaises(GradeValidatorException, GradeValidator.validate, grade2)

class TestStudentService(TestCase):
    def setUp(self):
        super().setUp()
        self.__student_repository = Repository(StudentValidator)
        self.__student_service = StudentService(self.__student_repository)

    def test_add_student__verify_if_student_is_incorrectly_added__test_faills_if_correctly_added(self):
        element = ["1", "Maria"]
        self.__student_service.addStudent(element)
        self.assertNotEqual(self.__student_service.get_all_students()[0].name, "Maria")

    def test_get_all_students__verify_if_all_students_are_counted__test_fails_if_incorrectly_counted(self):
        element = ["1", "Maria"]
        self.__student_service.addStudent(element)
        self.assertEqual(len(self.__student_service.get_all_students()), 1)

    def test_remove_student__verify_if_correctly_removed_student__test_faills_if_incorrectly_removed(self):
        element = ["1", "Maria"]
        self.__student_service.addStudent(element)
        self.__student_service.removeStudent([1])
        self.assertEqual(len(self.__student_service.get_all_students()), 0)

    def test_undo_op(self):
        assert(self.__student_service.undo_op() == None)

    def test_redo_op(self):
        assert (self.__student_service.redo_op(False) == None)

class TestDisciplineService(TestCase):
    def setUp(self):
        super().setUp()
        self.__discipline_repository = Repository(DisciplineValidator)
        self.__discipline_service = DisciplineService(self.__discipline_repository)

    def test_add_discipline__verify_if_discipline_is_incorrectly_added__test_faills_if_correctly_added(self):
        element = ["1", "Mate"]
        self.__discipline_service.addDiscipline(element)
        self.assertNotEqual(self.__discipline_service.get_all_disciplines()[0].name, "Mate")

    def test_get_all_disciplines__verify_if_all_disciplines_are_counted__test_fails_if_incorrectly_counted(self):
        element = ["1", "Maria"]
        self.__discipline_service.addDiscipline(element)
        self.assertEqual(len(self.__discipline_service.get_all_disciplines()), 1)

    def test_remove_discipline__verify_if_correctly_removed_discipline__test_faills_if_incorrectly_removed(self):
        element = ["1", "Maria"]
        self.__discipline_service.addDiscipline(element)
        self.__discipline_service.removeDiscipline([1])
        self.assertEqual(len(self.__discipline_service.get_all_disciplines()), 0)


class TestGradeService(TestCase):
    def setUp(self):
        super().setUp()
        self.__student_repository = Repository(StudentValidator)
        self.__student_service = StudentService(self.__student_repository)
        self.__discipline_repository = Repository(DisciplineValidator)
        self.__discipline_service = DisciplineService(self.__discipline_repository)
        self.__grade_repository = Repository(GradeValidator)
        self.__grade_service = GradeService(self.__grade_repository, self.__student_repository, self.__discipline_repository)

    def test_add_discipline__verify_if_discipline_is_incorrectly_added__test_faills_if_correctly_added(self):
        element = ["1", "Mate"]
        self.__discipline_service.addDiscipline(element)
        self.assertNotEqual(self.__discipline_service.get_all_disciplines()[0].name, "Mate")

    def test_get_all_disciplines__verify_if_all_disciplines_are_counted__test_fails_if_incorrectly_counted(self):
        element = ["1", "Maria"]
        self.__discipline_service.addDiscipline(element)
        self.assertEqual(len(self.__discipline_service.get_all_disciplines()), 1)

    def test_remove_discipline__verify_if_correctly_removed_discipline__test_faills_if_incorrectly_removed(self):
        element = ["1", "Maria"]
        self.__discipline_service.addDiscipline(element)
        self.__discipline_service.removeDiscipline([1])
        self.assertEqual(len(self.__discipline_service.get_all_disciplines()), 0)
