#include "Operations.h"

Operation* createOperation(Offer* offer, char* type)
{
	Operation* operation = (Operation*)malloc(sizeof(Operation));
	operation->offer = copyOffer(offer);
	operation->type = (char*)malloc(sizeof(char) * strlen(type) + 1);
	strcpy(operation->type, type);

	return operation;
}

void destroyOperation(Operation* operation)
{
	if (operation == NULL)
	{
		return;
	}
	destroyOffer(operation->offer);
	free(operation);
}

Operation* copyOperation(Operation* operation)
{
	Operation* newOperation = createOperation(getOperationOffer(operation), getOperationType(operation));
	return newOperation;
}

char* getOperationType(Operation* operation)
{
	if (operation == NULL)
	{
		return -1;
	}
	return operation->type;
}

Offer* getOperationOffer(Operation* operation)
{
	return operation->offer;
}

OperationStack* createOperationStack()
{
	OperationStack* stack = (OperationStack*)malloc(sizeof(OperationStack));
	stack->length = 0;
	return stack;
}

void destroyOperationStack(OperationStack* stack)
{
	for (int i = 0; i < stack->length; i++)
	{
		destroyOperation(stack->operations[i]);
	}
	free(stack);
}

void push(OperationStack* stack, Operation* operation)
{
	if (stack->length == 100)
	{
		return;
	}
	stack->operations[stack->length] = copyOperation(operation);
	stack->length++;
}

Operation* pop(OperationStack* stack)
{
	if (stack->length == 0)
	{
		return NULL;
	}
	Operation* operation = stack->operations[stack->length - 1];
	stack->length--;
	return operation;

}