class StoreException(Exception):
    pass

class RedoException(StoreException):
    pass


class UndoException(StoreException):
    pass


class UndoController:
    def __init__(self):
        self._operations = []
        self._index = -1
        self._recorded = True

    def recordOperation(self, operation):
        if self.isRecorded() == True:
            self._operations[-1].append(operation)

    def newOperation(self):
        if self.isRecorded() == False:
            return

        self._operations = self._operations[0:self._index + 1]
        self._operations.append([])
        self._index += 1

    def isRecorded(self):
        return self._recorded

    def undo(self):
        if self._index < 0:
            raise UndoException("Too many undo!")

        self._recorded = False

        for operation in self._operations[self._index]:
            operation.undo()

        self._recorded = True

        self._index -= 1
        return True

    def redo(self):
        if self._index +1 > len(self._operations) - 1:
            raise RedoException("Too many redo!")

        self._recorded = False

        self._index += 1

        for operation in self._operations[self._index]:
            operation.redo()

        self._recorded = True

        return True


class FunctionCall:
    def __init__(self, function_reference, *parameters):
        self._function_reference = function_reference
        self._parameters = parameters

    def call(self):
        self._function_reference(*self._parameters)


class Operation:
    def __init__(self, functionDo, functionUndo):
        self._functionDo = functionDo
        self._functionUndo = functionUndo

    def undo(self):
        self._functionUndo.call()

    def redo(self):
        self._functionDo.call()
