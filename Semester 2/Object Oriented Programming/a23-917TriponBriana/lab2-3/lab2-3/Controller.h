#pragma once
#include "Repository.h"
#include "Operations.h"

typedef struct {
	RepoOffer* repo;
	OperationStack* undo_stack;
	OperationStack* redo_stack;
}ControllerOffer;

ControllerOffer* createController(RepoOffer* repo, OperationStack* undo_stack, OperationStack* redo_stack);
void destroyController(ControllerOffer* controller);
int getControllerLength(ControllerOffer* controller);
RepoOffer* getElementFromPositionController(ControllerOffer* controller, int position);
int addController(ControllerOffer* controller, char* type, char* destination, double price, int day, int month, int year);
RepoOffer* getRepo(ControllerOffer* controller);
int deleteController(ControllerOffer* controller, char* destination, int day, int month, int year);
int updateController(ControllerOffer* controller, char* type, char* destination, double price, int day, int month, int year);
RepoOffer* filterByKeyword(ControllerOffer* controller, char key[]);
RepoOffer* sortRepo(ControllerOffer* controller, RepoOffer* repo);
int undo(ControllerOffer* controller);
int redo(ControllerOffer* controller);
void controllerTests();