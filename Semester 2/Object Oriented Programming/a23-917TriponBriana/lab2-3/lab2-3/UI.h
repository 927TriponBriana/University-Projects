#pragma once
#include "Controller.h"

typedef struct {
	ControllerOffer* controller;
}UI;

UI* createUI(ControllerOffer* controller);
void destroy(UI* ui);
void run(UI* ui);