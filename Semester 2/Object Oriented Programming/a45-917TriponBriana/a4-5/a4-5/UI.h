#pragma once
#include "Service.h"
#include "UserService.h"

class UI
{
private:
	Service& service;
	UserService& user_service;

public:
	
	UI(Service& serv, UserService& user_serv) : service(serv), user_service(user_serv) {}
	~UI();
	void run();

private:
	string EXIT_CHOICE = "0";
	string ADMINISTRATOR_MODE_CHOICE = "1";
	string USER_MODE_CHOICE = "2";
	string ADMINISTRATOR_EXIT_CHOICE = "0";
	string ADMINISTRATOR_ADD_CHOICE = "1";
	string ADMINISTRATOR_DISPLAY_CHOICE = "2";
	string ADMINISTRATOR_REMOVE_CHOICE = "3";
	string ADMINISTRATOR_UPDATE_CHOICE = "4";
	string USER_EXIT_CHOICE = "0";
	string USER_LIST_ONE_BY_ONE_CHOICE = "1";
	string USER_LIST_FILTERED_CHOICE = "2";
	string USER_LIST_ADOPTION_CHOICE = "3";

	static void print_menu();

	static void print_administrator_menu();
	static void print_dogs(DynamicArray<Dog> dogs);

	static void print_user_menu();

	void add_dog_to_service();

	void display_dogs_service();

	static bool string_validator(string given_string);

	void remove_dog_from_service();

	void update_dog_from_service();

	void administrator_mode();

	void user_mode();

	void list_dogs_one_by_one_user();

	void list_filtered_dogs_user();

	void list_adoption_list();


};