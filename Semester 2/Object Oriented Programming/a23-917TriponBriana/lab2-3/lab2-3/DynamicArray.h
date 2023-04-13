#pragma once
#include <stdio.h>
#include "Domain.h"
#include <stddef.h>

typedef Offer* TElem;


typedef struct {
	int length;
	int capacity;
	TElem* elements;
}DynaminArray;

DynaminArray* allocateArray(int capacity);
void deallocateArray(DynaminArray* array);
void addToArray(DynaminArray* array, TElem element);
void growCapacity(DynaminArray* array);
int searchByDestination(DynaminArray* array, char* destination, int day, int month, int year);
void deleteFromArray(DynaminArray* array, int position);
void updateArray(DynaminArray* array, int position, TElem element);
int getLength(DynaminArray* array);