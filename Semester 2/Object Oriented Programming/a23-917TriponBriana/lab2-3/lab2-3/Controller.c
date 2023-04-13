#include "Controller.h"
#include<stdlib.h>
#include <string.h>
#include <assert.h>

ControllerOffer* createController(RepoOffer* repo, OperationStack* undo_stack, OperationStack* redo_stack)
{
    ControllerOffer* controller = (ControllerOffer*)malloc(sizeof(ControllerOffer));
    if (controller == NULL)
    {
        return NULL;
    }
    controller->repo = repo;
    controller->undo_stack = undo_stack;
    controller->redo_stack = redo_stack;

    return controller;
}

void destroyController(ControllerOffer* controller)
{
    if (controller == NULL)
    {
        return;
    }
    destroyRepo(controller->repo);
    free(controller);
}

int getControllerLength(ControllerOffer* controller)
{
    return getLength(controller->repo->offers);
}

RepoOffer* getElementFromPositionController(ControllerOffer* controller, int position)
{
    if (controller == NULL)
    {
        return NULL;
    }
    if (position < 0 || position >= getControllerLength(controller))
    {
        return NULL;
    }
    return controller->repo->offers->elements[position];
}

RepoOffer* filterByKeyword(ControllerOffer* controller, char key[])
{
    int index;
    RepoOffer* repo = createRepo();
    for (index = 0; index < getControllerLength(controller); index++)
    {
        if (strstr(getDestination(getElementFromPositionController(controller, index)), key) != NULL)
        {
            addRepo(repo, getElementFromPositionController(controller, index));
        }
    }
    return repo;
}

RepoOffer* sortRepo(ControllerOffer* controller, RepoOffer* repo)
{
    int index, counter;
    Offer* auxOffer;
    for (index = 0; index < getRepoLength(repo) - 1; index++)
    {
        for (counter = index + 1; counter < getRepoLength(repo); counter++)
        {
            if (getElementFromPosition(repo, index) < getElementFromPosition(repo, counter))
            {
                auxOffer = getElementFromPosition(repo, counter);//  repo->offers->elems[j];
                repo->offers->elements[counter] = getElementFromPosition(repo, index); //  repo->offers->elems[index];
                repo->offers->elements[index] = auxOffer;
            }
        }
    }
    return repo;
}

int undo(ControllerOffer* controller)
{
    if (controller->undo_stack->length == 0)
    {
        return 0;
    }
    Operation* operation = pop(controller->undo_stack);
    Operation* redo_operation = copyOperation(operation);
    if (strcmp(getOperationType(redo_operation), "add") == 0)
    {
        redo_operation->type = "delete";
    }
    else if (strcmp(getOperationType(redo_operation), "delete") == 0)
    {
        redo_operation->type = "add";
    }

    if (strcmp(getOperationType(operation), "add") == 0)
    {
        Offer* offer = copyOffer(getOperationOffer(operation));
        deteletRepo(controller->repo, offer->destination, offer->day, offer->month, offer->year);
    }
    else if (strcmp(getOperationType(operation), "delete") == 0)
    {
        Offer* offer = copyOffer(getOperationOffer(operation));
        addRepo(controller->repo, offer);
    }
    else if (strcmp(getOperationType(operation), "update") == 0)
    {
        Offer* offer = copyOffer(getOperationOffer(operation));
        redo_operation->offer = copyOffer(updtateRepo(controller->repo, offer));
    }
    push(controller->redo_stack, redo_operation);
    destroyOperation(redo_operation);
    destroyOperation(operation);
    return 1;
}

int redo(ControllerOffer* controller)
{
    if (controller->redo_stack->length == 0)
    {
        return 0;
    }
    Operation* operation = pop(controller->redo_stack);
    Operation* undo_operation = copyOperation(operation);
    if (strcmp(getOperationType(undo_operation), "add") == 0)
    {
        undo_operation->type = "delete";
    }
    else if (strcmp(getOperationType(undo_operation), "delete") == 0)
    {
        undo_operation->type = "add";
    }

    if (strcmp(getOperationType(operation), "add") == 0)
    {
        Offer* offer = copyOffer(getOperationOffer(operation));
        deteletRepo(controller->repo, offer->destination, offer->day, offer->month, offer->year);

    }
    else if (strcmp(getOperationType(operation), "delete") == 0)
    {
        Offer* offer = copyOffer(getOperationOffer(operation));
        addRepo(controller->repo, offer);
    }
    else if (strcmp(getOperationType(operation), "update") == 0)
    {
        Offer* offer = copyOffer(getOperationOffer(operation));
        undo_operation->offer = copyOffer(updtateRepo(controller->repo, offer));
    }
    push(controller->undo_stack, undo_operation);
    destroyOperation(undo_operation);
    destroyOperation(operation);
    return 1;
}


int addController(ControllerOffer* controller, char* type, char* destination, double price, int day, int month, int year)
{
    int result;
    Offer* offer = createOffer(type, destination, price, day, month, year);
    result = addRepo(controller->repo, offer);
    if (result == 0)
    {
        destroyOffer(offer);
    }
    if (result == 1)
    {
        Operation* operation = createOperation(offer, "add");
        push(controller->undo_stack, operation);
        destroyOperation(operation);
        destroyOperationStack(controller->redo_stack);
        controller->redo_stack = createOperationStack();
    }

    return result;
}

RepoOffer* getRepo(ControllerOffer* controller)
{
    return controller->repo;
}

int deleteController(ControllerOffer* controller, char* destination, int day, int month, int year)
{
    Offer* result = deteletRepo(controller->repo, destination, day, month, year);
    if (result != NULL)
    {
        Operation* operation = createOperation(result, "delete");
        push(controller->undo_stack, operation);
        destroyOperation(operation);
        destroyOperationStack(controller->redo_stack);
        controller->redo_stack = createOperationStack();
        return 1;
    }
    return 0;
}

int updateController(ControllerOffer* controller, char* type, char* destination, double price, int day, int month, int year)
{
    Offer* newOffer = createOffer(type, destination, price, day, month, year);
    Offer* result = updtateRepo(controller->repo, newOffer);
    if (result != NULL)
    {
        Operation* operation = createOperation(result, "update");
        push(controller->undo_stack, operation);
        destroyOperation(operation);
        destroyOperationStack(controller->redo_stack);
        controller->redo_stack = createOperationStack();
        return 1;
    }
    return 0;

}

//TESTS
void initControllerOfferForTests(ControllerOffer* controller)
{
    Offer* offer = createOffer("seaside", "Greece", 150, 2, 5, 2023);
    char* type = getType(offer);
    char* destination = getDestination(offer);
    double price = getPrice(offer);
    int day = getDay(offer);
    int month = getMonth(offer);
    int year = getYear(offer);
    addController(controller, type, destination, price, day, month, year);


}

void testAdd()
{
    RepoOffer* repo = createRepo();
    OperationStack* undo_stack = createOperationStack();
    OperationStack* redo_stack = createOperationStack();
    ControllerOffer* controller = createController(repo, undo_stack, redo_stack);
    initControllerOfferForTests(controller);
    assert(getControllerLength(controller) == 1);

    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2023);
    char* type = getType(offer);
    char* destination = getDestination(offer);
    double price = getPrice(offer);
    int day = getDay(offer);
    int month = getMonth(offer);
    int year = getYear(offer);
    assert(addController(controller, type, destination, price, day, month, year) == 1);
    assert(getControllerLength(controller) == 2);

    assert(addController(controller, type, destination, price, day, month, year) == 0);
    destroyRepo(repo);
    destroyController(controller);
}

void testDelete()
{
    RepoOffer* repo = createRepo();
    OperationStack* undo_stack = createOperationStack();
    OperationStack* redo_stack = createOperationStack();
    ControllerOffer* controller = createController(repo, undo_stack, redo_stack);
    initControllerOfferForTests(controller);
    assert(getControllerLength(controller) == 1);
    assert(deleteController(controller, "greece", 2, 5, 2023) == 1);
    assert(getControllerLength(controller) == 0);
    assert(deleteController(controller, "greece", 2, 5, 2023) == 0);
    destroyRepo(repo);
    destroyController(controller);
}

void testUpdate()
{
    RepoOffer* repo = createRepo();
    OperationStack* undo_stack = createOperationStack();
    OperationStack* redo_stack = createOperationStack();
    ControllerOffer* controller = createController(repo, undo_stack, redo_stack);
    initControllerOfferForTests(controller);
    assert(getControllerLength(controller) == 1);
    destroyRepo(repo);
    destroyController(controller);
}

void testUndo()
{
    RepoOffer* repo = createRepo();
    OperationStack* undo_stack = createOperationStack();
    OperationStack* redo_stack = createOperationStack();
    ControllerOffer* controller = createController(repo, undo_stack, redo_stack);
    initControllerOfferForTests(controller);
    assert(getControllerLength(controller) == 1);

    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2023);
    char* type = getType(offer);
    char* destination = getDestination(offer);
    double price = getPrice(offer);
    int day = getDay(offer);
    int month = getMonth(offer);
    int year = getYear(offer);
    assert(addController(controller, type, destination, price, day, month, year) == 1);
    undo(controller);
    assert(getControllerLength(controller) == 0);
    destroyRepo(repo);
    destroyController(controller);

    //RepoOffer* repo = createRepo();
    //OperationStack* undo_stack = createOperationStack();
    //OperationStack* redo_stack = createOperationStack();
    //ControllerOffer* controller = createController(repo, undo_stack, redo_stack);
    //initControllerOfferForTests(repo);
    //assert(getRepoLength(repo) == 1);

    //Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2023);
    //assert(addRepo(repo, offer) == 1);
    //undo(controller);
    //assert(getRepoLength(repo) == 0);
    //destroyRepo(repo);
    //destroyController(controller);
}

void testRedo()
{
    RepoOffer* repo = createRepo();
    OperationStack* undo_stack = createOperationStack();
    OperationStack* redo_stack = createOperationStack();
    ControllerOffer* controller = createController(repo, undo_stack, redo_stack);
    initControllerOfferForTests(controller);
    assert(getControllerLength(controller) == 1);

    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2023);
    char* type = getType(offer);
    char* destination = getDestination(offer);
    double price = getPrice(offer);
    int day = getDay(offer);
    int month = getMonth(offer);
    int year = getYear(offer);
    assert(addController(controller, type, destination, price, day, month, year) == 1);
    undo(controller);
    assert(getControllerLength(controller) == 0);
    redo(controller);
    assert(getRepoLength(repo) == 1);
    destroyRepo(repo);
    destroyController(controller);


    /*RepoOffer* repo = createRepo();
    OperationStack* undo_stack = createOperationStack();
    OperationStack* redo_stack = createOperationStack();
    ControllerOffer* controller = createController(repo, undo_stack, redo_stack);
    initControllerOfferForTests(repo);
    assert(getRepoLength(repo) == 1);
    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2023);
    assert(addRepo(repo, offer) == 1);
    undo(controller);
    assert(getRepoLength(repo) == 0);
    redo(controller);
    assert(getRepoLength(repo) == 1);
    destroyRepo(repo);
    destroyController(controller);*/
}

void testSortRepo()
{
    RepoOffer* repo = createRepo();
    OperationStack* undo_stack = createOperationStack();
    OperationStack* redo_stack = createOperationStack();
    ControllerOffer* controller = createController(repo, undo_stack, redo_stack);
    initControllerOfferForTests(repo);
    assert(getRepoLength(repo) == 1);

    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2023);
    assert(addRepo(repo, offer) == 1);
    sortRepo(controller, repo);
    assert(repo->offers->elements[0]->price == 150);
    assert(repo->offers->elements[1]->price == 300);
    destroyRepo(repo);
    destroyController(controller);
}

void testFilterKeyword()
{
    RepoOffer* repo = createRepo();
    OperationStack* undo_stack = createOperationStack();
    OperationStack* redo_stack = createOperationStack();
    ControllerOffer* controller = createController(repo, undo_stack, redo_stack);
    initControllerOfferForTests(repo);
    assert(getRepoLength(repo) == 1);

    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2023);
    assert(addRepo(repo, offer) == 1);
    assert(getRepoLength(repo) == 2);
    filterByKeyword(controller, "Budapest");
    assert(getRepoLength(repo) == 1);
    destroyRepo(repo);
    destroyController(controller);
}

void controllerTests()
{
    testAdd();
    testDelete();
    testUpdate();
    testUndo();
    testRedo();
    testSortRepo();
    testFilterKeyword();
}