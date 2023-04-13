#include "Repository.h"
#include <stdlib.h>
#include <string.h>
#include <assert.h>

RepoOffer* createRepo()
{
    RepoOffer* repo = (RepoOffer*)malloc(sizeof(RepoOffer));
    if (repo == NULL)
    {
        return NULL;
    }
    repo->offers = allocateArray(20);
    if (repo->offers == NULL)
    {
        return NULL;
    }

    return repo;
}

void destroyRepo(RepoOffer* repo)
{
    deallocateArray(repo->offers);
    free(repo);
}

int addRepo(RepoOffer* repo, TElem element)
{
    if (searchByDestination(repo->offers, element->destination, element->day, element->month, element->year) == -1)
    {
        addToArray(repo->offers, element);
        return 1;
    }
    else
    {
        return 0;
    }
}

int getRepoLength(RepoOffer* repo)
{
    return getLength(repo->offers);
}

Offer* getElementFromPosition(RepoOffer* repo, int position)
{
    if (repo == NULL)
    {
        return NULL;
    }
    if (position < 0 || position >= getRepoLength(repo))
    {
        return NULL;
    }
    return repo->offers->elements[position];
}


Offer* deteletRepo(RepoOffer* repo, char* destination, int day, int month, int year)
{
    int position = searchByDestination(repo->offers, destination, day, month, year);
    if (position == -1)
    {
        return NULL;
    }
    Offer* newOffer = copyOffer(getElementFromPosition(repo, position));  //copyOffer(repo->offers->elems[pos]);
    deleteFromArray(repo->offers, position);
    return newOffer;
}

Offer* updtateRepo(RepoOffer* repo, TElem element)
{
    int position = searchByDestination(repo->offers, element->destination, element->day, element->month, element->year);
    if (position < 0 || position >= getRepoLength(repo))
    {
        return NULL;
    }
    Offer* newOffer = copyOffer(getElementFromPosition(repo, position));
    updateArray(repo->offers, position, element);
    return newOffer;
}


//TESTS
//void initRepoOfferForTests(RepoOffer* repo)
//{
//    Offer* offer = createOffer("seaside", "Greece", 150, 2, 5, 2023);
//    addRepo(repo, offer);
//}

//void testAdd()
//{
//    RepoOffer* repo = createRepo();
//    initRepoOfferForTests(repo);
//    assert(getRepoLength(repo) == 1);
//
//    Offer* offer = createOffer("city break", "Budapest", 300, 10, 9, 2023);
//    assert(addRepo(repo, offer) == 1);
//    assert(getRepoLength(repo) == 2);
//
//    assert(addRepo(repo, offer) == 0);
//    destroyRepo(repo);
//}

//void testDelete()
//{
//    RepoOffer* repo = createRepo();
//    initRepoOfferForTests(repo);
//    assert(getRepoLength(repo) == 1);
//    assert(deteletRepo(repo, "greece", 2, 5, 2023) == 1);
//    assert(getRepoLength(repo) == 0);
//    assert(deteletRepo(repo, "greece", 2, 5, 2023) == 0);
//    destroyRepo(repo);
//}

//void testUpdate()
//{
//    RepoOffer* repo = createRepo();
//    initRepoOfferForTests(repo);
//    assert(getRepoLength(repo) == 1);
//    destroyRepo(repo);
//}

//void testGetLength()
//{
//    RepoOffer* repo = createRepo();
//    initRepoOfferForTests(repo);
//    assert(getRepoLength(repo) == 1);
//    //destroyRepo(repo);
//}
//
//void repoTests()
//{
//    testAdd();
//    testDelete();
//    testUpdate();
//    testGetLength();
//}