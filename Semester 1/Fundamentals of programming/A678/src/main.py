from src.service.discipline_service import DisciplineService
from src.service.grade_service import GradeService
from src.service.student_service import StudentService
from src.service.undo_redo_service import UndoController
from src.domain.entities import Student, Discipline, Grade, Settings
from src.domain.validators import StudentValidator, DisciplineValidator, GradeValidator
from src.repository.file_repository import FileRepository
from src.repository.binary_repository import BinaryRepository
from src.repository.json_repository import JSONRepository
from src.repository.repository import Repository
from src.ui.console import Console

def runApplicationWithUndo():
    settings = Settings()
    undo_controller = UndoController()

    if str(settings.mode_repository) == "inmemory":
        student_repository = Repository(StudentValidator)
        discipline_repository = Repository(DisciplineValidator)
        grade_repository = Repository(GradeValidator)

    elif settings.mode_repository == "textfiles":
        student_repository = FileRepository(StudentValidator, settings.students, Student)
        discipline_repository = FileRepository(DisciplineValidator, settings.disciplines, Discipline)
        grade_repository = FileRepository(GradeValidator, settings.grades, Grade)

    elif settings.mode_repository == "binaryfiles":
        student_repository = BinaryRepository(StudentValidator, settings.students, Student)
        discipline_repository = BinaryRepository(DisciplineValidator, settings.disciplines, Discipline)
        grade_repository = BinaryRepository(GradeValidator, settings.grades, Grade)

    elif settings.mode_repository == "jsonfiles":
        student_repository = JSONRepository(StudentValidator, settings.students, Student)
        discipline_repository = JSONRepository(DisciplineValidator, settings.disciplines, Discipline)
        grade_repository = JSONRepository(GradeValidator, settings.grades, Grade)

    else:
        print("You have to insert a valid repository mode!")

    student_service = StudentService(student_repository, undo_controller)
    discipline_service = DisciplineService(discipline_repository, undo_controller)
    grade_service = GradeService(grade_repository, student_repository, discipline_repository,undo_controller)

    if settings.interface_mode == "console":
        console = Console(student_service, discipline_service, grade_service, undo_controller)
        console.runApp()

if __name__ == '__main__':
    try:
        runApplicationWithUndo()
    except Exception as ex:
        print(ex)