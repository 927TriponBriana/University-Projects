
from service.undo_redo_service import FunctionCall, Operation
from domain.entities import Discipline

from util.util import Util


class DisciplineService(object):
    def __init__(self, discipline_repository, undoController):
        self.__discipline_repository = discipline_repository
        self.__undoController = undoController

    def addDiscipline(self, disciplineID, name):
        """
        Add a discipline to the repository
        :param: the discipline arguments
        """

        discipline = Discipline(disciplineID, name)
        self.__discipline_repository.save(discipline)

        redo = FunctionCall(self.addDiscipline, disciplineID, name)
        undo = FunctionCall(self.removeDiscipline, disciplineID)
        operation = Operation(redo, undo)
        self.__undoController.recordOperation(operation)


    def get_all_discipline(self):
        """
        Return all disciplines from repository
        """
        return self.__discipline_repository.get_all()

    def get_all_id(self):
        """
        Return all disciplines id from repository
        """
        return self.__discipline_repository.get_all_id()

    def removeDiscipline(self, disciplineID):
        """
        Remove a discipline from the repository
        :param: the discipline arguments
        """
        discipline_name = self.searchByID(disciplineID).name
        self.__discipline_repository.delete(disciplineID)

        redo = FunctionCall(self.removeDiscipline, disciplineID)
        undo = FunctionCall(self.addDiscipline, disciplineID, discipline_name)
        operation = Operation(redo, undo)
        self.__undoController.recordOperation(operation)

    def updateDiscipline(self, disciplineID, name):
        """
        Update a discipline from the repository
        :param: the discipline arguments
        """
        discipline = Discipline(disciplineID, name)
        self.__discipline_repository.update(discipline)

        redo = FunctionCall(self.updateDiscipline, disciplineID, name)
        undo = FunctionCall(self.updateDiscipline, disciplineID)
        operation = Operation(redo, undo)
        self.__undoController.recordOperation(operation)


    def searchByID(self, id):
        """
        Return the discipline identity with the checked id
        :param id: the id entity to searched; the "id" must already exist.
        :return: searched discipline entity or an empty list
        """
        return self.__discipline_repository.findByID(id)

    def searchByName(self, name):
        """
        Return a list of discipline entities with the name containing a substring
        :param name: the substring
        :return: searched discipline entities or an empty list
        """
        #return self.__discipline_repository.findByName(given_name)
        return Util.filterFunction(self.get_all_discipline(), lambda x: name.lower() in x.name.lower())

    def searchDisciplines(self, discipline):
        """
        Check if the argument received is the id or a name
        :param: the argument
        :return: the checked entity or a list of entities
        """
        if str(discipline[0]).isdigit():
            return self.searchByID(int(discipline[0]))
        else:
            return self.searchByName(discipline[0])
