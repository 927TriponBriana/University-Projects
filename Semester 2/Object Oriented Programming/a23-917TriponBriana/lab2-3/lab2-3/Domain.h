#pragma once

typedef struct
{
	char* type;
	char* destination;
	double price;
	int day, month, year;
} Offer;

Offer* createOffer(char* type, char* destination, double price, int day, int month, int year);
void destroyOffer(Offer* offer);
Offer* copyOffer(Offer* offer);
char* getType(Offer* offer);
char* getDestination(Offer* offer);
double getPrice(Offer* offer);
int getDay(Offer* offer);
int getMonth(Offer* offer);
int getYear(Offer* offer);
void toString(Offer* offer, char string[]);