#pragma once
#include "DynamicArray.h"
#include <stddef.h>

typedef struct {
	DynaminArray* offers;
} RepoOffer;

RepoOffer* createRepo();
void destroyRepo(RepoOffer* repo);
int addRepo(RepoOffer* repo, TElem element);
int getRepoLength(RepoOffer* repo);
Offer* getElementFromPosition(RepoOffer* repo, int position);
Offer* deteletRepo(RepoOffer* repo, char* destination, int day, int month, int year);
Offer* updtateRepo(RepoOffer* repo, TElem element);
//void repoTests();