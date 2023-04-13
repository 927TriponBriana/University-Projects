#include "Repository.h"
#include "Controller.h"
#include "UI.h"
#include <crtdbg.h>

int main()
{
	RepoOffer* repo = createRepo();
	OperationStack* undo_stack = createOperationStack();
	OperationStack* redo_stack = createOperationStack();
	ControllerOffer* controller = createController(repo, undo_stack, redo_stack);
	addController(controller, "seaside", "Greece", 150, 2, 5, 2023);
	addController(controller, "seaside", "Barcelona", 300, 1, 6, 2023);
	addController(controller, "seaside", "Italy", 600, 7, 6, 2023);
	addController(controller, "mountain", "Italy", 400, 8, 10, 2024);
	addController(controller, "mountain", "Switzerland", 250, 20, 7, 2023);
	addController(controller, "citybreak", "Madrid", 300, 19, 6, 2023);
	addController(controller, "citybreak", "Paris", 350, 25, 7, 2024);
	addController(controller, "citybreak", "Amsterdam", 300, 20, 8, 2023);
	addController(controller, "citybreak", "London", 250, 11, 6, 2023);
	addController(controller, "citybreak", "Budapest", 300, 10, 9, 2023);
	UI* ui = createUI(controller);
	run(ui);
	destroy(ui);
	_CrtDumpMemoryLeaks();
	return 0;
}