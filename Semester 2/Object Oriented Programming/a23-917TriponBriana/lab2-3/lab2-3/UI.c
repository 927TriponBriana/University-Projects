#include "UI.h"
#include <stdlib.h>
#include <stdio.h>

UI* createUI(ControllerOffer* controller)
{
    UI* ui = (UI*)malloc(sizeof(UI));
    if (ui == NULL)
    {
        return NULL;
    }
    ui->controller = controller;
    return ui;
}

void destroy(UI* ui)
{
    if (ui == NULL)
    {
        return;
    }
    destroyController(ui->controller);
    free(ui);
}

int getUILength(UI* ui)
{
    return getLength(ui->controller->repo->offers);
}

ControllerOffer* getElementFromPositionUI(UI* ui, int position)
{
    if (ui == NULL)
    {
        return NULL;
    }
    if (position < 0 || position >= getUILength(ui))
    {
        return NULL;
    }
    return ui->controller->repo->offers->elements[position];
}

int getInteger(const char* message)
{
    char string[16] = { 0 };
    int ok = 0;
    int result = 0;
    int number = 0;
    while (ok == 0)
    {
        printf(message);
        int input = scanf("%15s", string);
        number = sscanf(string, "%d", &result);	// reads data from s and stores them as integer, if possible; returns 1 if successful
        ok = (number == 1);
        if (ok == 0)
        {
            printf("Error reading number!\n");
        }
    }
    return result;
}

void printOffers(UI* ui)
{
    if (ui == NULL)
    {
        return;
    }
    RepoOffer* repo = getRepo(ui->controller);
    if (repo == NULL)
    {
        return;
    }
    for (int index = 0; index < getRepoLength(repo); index++)
    {
        char OfferString[200];
        toString(getElementFromPosition(repo, index), OfferString);
        //toString(repo->offers->elems[i], OfferString);
        printf("%d. %s\n", index + 1, OfferString);
    }
    /*int length = getRepoLength(repo);
    if (length == 0)
    {
        printf("There are bo offers!\n");
    }
    else
    {
        char str[500];
        for (int i = 0; i < length; i++)
        {
            toString(repo->estates->elems[i], str);
            printf("%s\n", str);
        }
    }*/

}

int validcommand(int command)
{
    if (command >= 0 && command <= 8)
        return 1;
    return 0;
}

int addUI(UI* ui)
{
    char type[50], destination[50];
    double price;
    int day = 0, month = 0, year = 0;
    printf("Give the type: ");
    int result = scanf("%49s", type);
    printf("Give the destination: ");
    result = scanf("%49s", destination);
    printf("Enter the price: ");
    result = scanf("%lf", &price);
    printf("Enter the day: ");
    result = scanf("%d", &day);
    printf("Enter the month: ");
    result = scanf("%d", &month);
    printf("Enter the year: ");
    result = scanf("%d", &year);

    return addController(ui->controller, type, destination, price, day, month, year);
}

void deleteUI(UI* ui)
{
    char destination[50];
    int day = 0, month = 0, year = 0;
    printf("Give the destination of the offer to be deleted: ");
    int result = scanf("%49s", destination);
    printf("Enter the day: ");
    result = scanf("%d", &day);
    printf("Enter the month: ");
    result = scanf("%d", &month);
    printf("Enter the year: ");
    result = scanf("%d", &year);

    int deleted = deleteController(ui->controller, destination, day, month, year);
    if (deleted == 0)
    {
        printf("Offer cannot be deleted!\n");
    }
    else {
        printf("Offer deleted successfully!\n");
    }
}

void updateUI(UI* ui)
{
    char type[50], destination[50];
    double price = 0;
    int day = 0, month = 0, year = 0;
    printf("Enter the destination of the offer to be updated: ");
    int result = scanf("%49s", destination);
    printf("Enter the day: ");
    result = scanf("%d", &day);
    printf("Enter the month: ");
    result = scanf("%d", &month);
    printf("Enter the year: ");
    result = scanf("%d", &year);

    printf("Enter the new type: ");
    result = scanf("%49s", type);

    printf("Please input the new price: ");
    result = scanf("%lf", &price);

    int updated = updateController(ui->controller, type, destination, price, day, month, year);

    if (updated == 0)
    {
        printf("Offer cannot be updated successfully!\n");
    }
    else
    {
        printf("Offer updated successfully!\n");
    }
}

void filterByDestination(UI* ui)
{
    char word[50], OfferString[100];
    printf("Enter the word to look for in destinations: ");
    int input = scanf("%49s", word);
    if (strcmp(word, "null") == 0)
    {
        printOffers(ui);
    }
    else
    {
        RepoOffer* repo = filterByKeyword(ui->controller, word);
        if (getRepoLength == 0)
        {
            printf("There are no items matching the given string!");
        }
        else
        {
            repo = sortRepo(ui->controller, repo);
            for (int index = 0; index < getRepoLength(repo); index++)
            {
                toString(getElementFromPosition(repo, index), OfferString);
                /* toString(repo->offers->elems[i], OfferString);*/
                printf("%d. %s\n", index + 1, OfferString);
            }
        }
    }
}

void filterByType(UI* ui)
{
    char given_type[50], matchingString[100];
    int day, month, year;
    printf("Enter the type that the elements should have: ");
    int result = scanf("%49s", given_type);
    printf("Enter the day: ");
    result = scanf("%d", &day);
    printf("Enter the month: ");
    result = scanf("%d", &month);
    printf("Enter the year: ");
    result = scanf("%d", &year);

    for (int index = 0; index < getUILength(ui); index++)
    {
        /*if (strstr(ui->controller->repo->offers->elems[j]->type, given_type) != NULL && ((ui->controller->repo->offers->elems[j]->day > day && ui->controller->repo->offers->elems[j]->month >= month && ui->controller->repo->offers->elems[j]->year >= year) || (ui->controller->repo->offers->elems[j]->day < day && ui->controller->repo->offers->elems[j]->month > month && ui->controller->repo->offers->elems[j]->year >= year) || (ui->controller->repo->offers->elems[j]->day <= day && ui->controller->repo->offers->elems[j]->month <= month && ui->controller->repo->offers->elems[j]->year > year)))
        {
            toString(ui->controller->repo->offers->elems[j], matchingString);
            printf("%d. %s\n", j + 1, matchingString);
        }*/
        Offer* offer = getElementFromPositionUI(ui, index);
        char* initial_type = getType(offer);
        int initial_day = getDay(offer);
        int initial_month = getMonth(offer);
        int initial_year = getYear(offer);
        if (strstr(initial_type, given_type) != NULL && ((initial_day > day && initial_month >= month && initial_year >= year) || (initial_day < day && initial_month > month && initial_year >= year) || (initial_day <= day && initial_month <= month && initial_year > year)))
        {
            /*toString(ui->controller->repo->offers->elems[j], matchingString);*/
            toString(getElementFromPositionUI(ui, index), matchingString);
            printf("%d. %s\n", index + 1, matchingString);
        }
    }
}

void printMenu()
{
    printf("1. Add offer.\n");
    printf("2. Print all offers.\n");
    printf("3. Delete offer.\n");
    printf("4. Update offer.\n");
    printf("5. Display all offers whose destination contain a given string sorted by price.\n");
    printf("6. Display all offers of a given type, having their departure after a given date. \n");
    printf("7. Undo.\n");
    printf("8. Redo.\n");
    printf("0. Exit.\n");
}

void run(UI* ui)
{
    while (1)
    {
        printMenu();
        int command = getInteger("Enter your option: ");
        while (validcommand(command) == 0)
        {
            printf("Please enter a valid command!\n");
            command = getInteger("Enter your option: ");
        }
        if (command == 0)
        {
            break;
        }
        switch (command)
        {
        case 1:
        {
            int result = addUI(ui);
            if (result == 1)
                printf("Offer successfully added.\n");
            else
                printf("Error! Offer could not be added. ");
            break;
        }
        case 2:
        {
            printOffers(ui);
            break;
        }
        case 3:
        {
            deleteUI(ui);
            break;
        }
        case 4:
        {
            updateUI(ui);
            break;
        }
        case 5:
        {
            filterByDestination(ui);
            break;
        }
        case 6:
        {
            filterByType(ui);
            break;
        }
        case 7:
        {
            int result = undo(ui->controller);
            if (result == 0)
            {
                printf("Undo is not possible!\n");
            }
            else
            {
                printf("Undo done successfully!\n");
            }
            break;
        }
        case 8:
        {
            int result = redo(ui->controller);
            if (result == 0)
            {
                printf("Redo is not possible!\n");
            }
            else
            {
                printf("Redo done successfully!\n");
            }
            break;
        }
        }
    }
}