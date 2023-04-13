#pragma once
#include <stdio.h>
#include <stdlib.h>
#include "DynamicArray.h"

typedef struct
{
	Offer* offer;
	char* type;
}Operation;

Operation* createOperation(Offer* offer, char* type);
void destroyOperation(Operation* operation);
Operation* copyOperation(Operation* operation);
char* getOperationType(Operation* operation);
Offer* getOperationOffer(Operation* operation);

typedef struct
{
	Operation* operations[100];
	int length;
}OperationStack;

OperationStack* createOperationStack();
void destroyOperationStack(OperationStack* stack);
void push(OperationStack* stack, Operation* operation);
Operation* pop(OperationStack* stack);