#include "UI.h"
#include <string>
#include <iostream>

using namespace std;

void UI::print_menu()
{
	cout << "1. Administrator mode." << endl;
	cout << "2. User mode." << endl;
	cout << "0. Exit" << endl;
}

void UI::print_administrator_menu()
{
	cout << " ~Administrator mode!~" << endl;
	cout << " Possible Commands: " << endl;
	cout << "\t 1. Add a dog." << endl;
	cout << "\t 2. List all the dogs." << endl;
	cout << "\t 3. Delete a dog." << endl;
	cout << "\t 4. Update a dog." << endl;
	cout << "\t 0. Exit administrator mode." << endl;
}

void UI::print_user_menu()
{
	cout << " ~User mode!~" << endl;
	cout << " Possible Commands: " << endl;
	cout << "\t 1. See dogs one by one." << endl;
	cout << "\t 2. See all dogs of a given breed having an age less than a given age." << endl;
	cout << "\t 3. See adoption list." << endl;
	cout << "\t 0. Exit user mode." << endl;
}


void UI::add_dog_to_service()
{
	cout << " Enter the breed: ";
	string breed;
	getline(cin, breed);
	if ((!string_validator(breed)) || (breed.length() == 0))
	{
		throw "The input for the breed is not valid!";
	}
	cout << " Enter the name: ";
	string name;
	getline(cin, name);
	if ((!string_validator(name)) || (name.length() == 0))
	{
		throw "The input for the name is not valid!";
	}
	cout << " Enter the age: ";
	string string_age;
	getline(cin, string_age);
	int age;
	if (!string_validator(string_age) && string_age.length() != 0)
	{
		age = stoi(string_age);
	}
	else
	{
		throw "The input for the age is not valid!";
	}
	if (age < 0)
	{
		throw "The age must be greater than 0!";
	}
	cout << " Enter the photograph link: ";
	string photo_link;
	getline(cin, photo_link);
	bool added = this->service.add_dog_to_repository(breed, name, age, photo_link);
	if (added == true)
	{
		cout << "\t The dog was added successfully!" << endl;
	}
	else
	{
		cout << "\t The dog cannot be added!" << endl;
	}
}

void UI::print_dogs(DynamicArray<Dog> dogs)
{
	if (!dogs.get_size())
	{
		cout << "There are no dogs!" << endl;
		return;
	}
	for (int current_dog_position = 0; current_dog_position < dogs.get_size(); current_dog_position++)
	{
		cout << current_dog_position + 1 << "." << dogs[current_dog_position].toString() << endl;
	}
}

void UI::display_dogs_service()
{
	print_dogs(this->service.get_all_dogs());
}

bool UI::string_validator(string given_string)
{
	for (int current_position = 0; current_position < given_string.length(); current_position++)
	{
		if (isdigit(given_string[current_position]) != false)
		{
			return false;
		}
	}
	return true;
}


void UI::remove_dog_from_service()
{
	cout << " Enter the breed: ";
	string breed;
	getline(cin, breed);
	if (!string_validator(breed) || breed.length() == 0)
	{
		throw "The input for the breed is not valid!";
	}
	cout << " Enter the name: ";
	string name;
	getline(cin, name);
	if (!string_validator(name) || name.length() == 0)
	{
		throw "The input for the name is not valid!";
	}
	bool deleted = this->service.delete_dog_from_repository(breed, name);
	if (deleted == true)
	{
		cout << "\t The dog was removed successfully!" << endl;
	}
	else
	{
		cout << "\t The dog does not exist!" << endl;
	}
}

void UI::update_dog_from_service()
{
	cout << " Enter the breed of the dog to be updated: ";
	string breed;
	getline(cin, breed);
	cout << " Enter the name of the dog to be updated: ";
	string name;
	getline(cin, name);

	cout << " Enter the new breed for the dog you would like to update: ";
	string new_breed;
	getline(cin, new_breed);
	cout << " Enter the new name for the dog you would like to update: ";
	string new_name;
	getline(cin, new_name);
	int age = 0;
	cout << " Enter the new age: ";
	cin >> age;
	cin.ignore();
	cout << " Enter photo link: ";
	string photo_link;
	getline(cin, photo_link);
	bool updated = this->service.update_dog_from_repository(breed, name, new_breed, new_name, age, photo_link);
	if (updated == true)
	{
		cout << "\t The dog was updated successfully!" << endl;
	}
	else
	{
		cout << "\t The dog does not exist!" << endl;
	}
}

//string EXIT_CHOICE = "0";
//string ADMINISTRATOR_MODE_CHOICE = "1";
//string USER_MODE_CHOICE = "2";

UI::~UI() = default;
void UI::run()
{
	while (true)
	{
		UI::print_menu();
		string command;
		cout << " Enter the command: ";
		getline(cin, command);
		if (command == EXIT_CHOICE)
		{
			break;
		}
		else if (command == ADMINISTRATOR_MODE_CHOICE)
		{
			administrator_mode();
		}
		else if (command == USER_MODE_CHOICE)
		{
			user_mode();
		}
		else
		{
			cout << "The command is not valid!" << endl;
		}
	}
}

//string ADMINISTRATOR_EXIT_CHOICE = "0";
//string ADMINISTRATOR_ADD_CHOICE = "1";
//string ADMINISTRATOR_DISPLAY_CHOICE = "2";
//string ADMINISTRATOR_REMOVE_CHOICE = "3";
//string ADMINISTRATOR_UPDATE_CHOICE = "4";

void UI::administrator_mode()
{
	while (true)
	{
		try {
			print_administrator_menu();
			string option;
			cout << "Enter the command: ";
			getline(cin, option);
			if (option == ADMINISTRATOR_EXIT_CHOICE)
			{
				break;
			}
			else if (option == ADMINISTRATOR_ADD_CHOICE)
			{
				this->add_dog_to_service();
			}
			else if (option == ADMINISTRATOR_DISPLAY_CHOICE)
			{
				this->display_dogs_service();
			}
			else if (option == ADMINISTRATOR_REMOVE_CHOICE)
			{
				this->remove_dog_from_service();
			}
			else if (option == ADMINISTRATOR_UPDATE_CHOICE)
			{
				this->update_dog_from_service();
			}
			else
			{
				cout << "The command is not valid!" << endl;
			}
		}
		catch (const char* message)
		{
			cout << message << endl;
		}
		catch (const exception& exception)
		{
			cerr << exception.what();
			cout << endl;
		}
	}
}

//string USER_EXIT_CHOICE = "0";
//string USER_LIST_ONE_BY_ONE_CHOICE = "1";
//string USER_LIST_FILTERED_CHOICE = "2";
//string USER_LIST_ADOPTION_CHOICE = "3";

void UI::user_mode()
{
	while (true)
	{
		try {
			print_user_menu();
			string option;
			cout << "Enter command: ";
			getline(cin, option);
			if (option == USER_EXIT_CHOICE)
			{
				break;
			}
			else if (option == USER_LIST_ONE_BY_ONE_CHOICE)
			{
				this->list_dogs_one_by_one_user();
			}
			else if (option == USER_LIST_FILTERED_CHOICE)
			{
				this->list_filtered_dogs_user();
			}
			else if (option == USER_LIST_ADOPTION_CHOICE)
			{
				this->list_adoption_list();
			}
			else
			{
				cout << "The command is not valid!" << endl;
			}
		}
		catch (const char* message)
		{
			cout << message << endl;
		}
		catch (const exception& exception)
		{
			cout << exception.what();
			cout << endl;
		}
	}
}

void UI::list_dogs_one_by_one_user()
{
	string option;
	int current_dog_position = 0;
	int length = this->service.get_all_dogs().get_size();
	if (length == 0)
	{
		throw "There are no dogs to adopt!";
	}
	while (true)
	{
		if (length == 0)
		{
			throw "There are no more dogs!";
		}

		if (current_dog_position == length)
		{
			current_dog_position = 0;
		}
		/*cout << this->service->get_all_service()[current_dog_position].toString() << endl;*/
		cout << this->service.get_all_dogs()[current_dog_position].toString() << endl;
		cout << "Would you like to adopt dog? [Yes / No / Exit]" << endl;
		string photo_link = string("start ").append(this->service.get_all_dogs()[current_dog_position].get_photograph());
		system(photo_link.c_str());
		getline(cin, option);
		if (option == "Yes")
		{
			DynamicArray<Dog> current_dogs = this->service.get_all_dogs();
			this->user_service.add_dog_to_user_repository(current_dogs[current_dog_position].get_breed(), current_dogs[current_dog_position].get_name(), current_dogs[current_dog_position].get_age(), current_dogs[current_dog_position].get_photograph());
			length = this->service.get_all_dogs().get_size();
		}
		else if (option == "No")
		{
			current_dog_position++;
		}
		else if (option == "Exit")
		{
			break;
		}
		if (length == 0)
		{
			break;
		}
	}
}

void UI::list_filtered_dogs_user()
{
	string given_breed, given_age;
	int age = 0;
	cout << "Enter the breed: ";
	getline(cin, given_breed);
	if (!string_validator(given_breed))
	{
		throw "The entered breed is not valid!";
	}
	cout << "Enter the age: ";
	getline(cin, given_age);
	if (!string_validator(given_age) && given_age.length() != 0)
	{
		age = stoi(given_age);
	}
	if ((int)age < 0)
	{
		throw "The entered age is not valid!";
	}
	/*auto* valid_dogs = new Dog[this->service->get_service_capacity()];*/
	auto valid_dogs = this->user_service.filter_dogs(given_breed, age);
	int length = valid_dogs.get_size();
	if (length == 0)
	{
		throw "There are no matching dogs!";
	}
	string option;
	bool done = false;
	int index = 0;
	while (!done)
	{
		if (length == 0)
		{
			throw "There are no more dogs!";
		}
		if (index == length)
		{
			index = 0;
		}
		cout << valid_dogs[index].toString() << endl;
		cout << "Would you like to adopt dog? [Yes / No / Exit]" << endl;
		string photo_link = string("start ").append(valid_dogs[index].get_photograph());
		system(photo_link.c_str());
		getline(cin, option);
		if (option == "Yes")
		{
			Dog dog = valid_dogs[index];
			this->user_service.add_dog_to_user_repository(dog.get_breed(), dog.get_name(), dog.get_age(), dog.get_photograph());
			for (int current_dog = index; current_dog < length - 1; current_dog++)
			{
				valid_dogs[current_dog] = valid_dogs[current_dog + 1];
			}
			length--;
		}
		else if (option == "No")
		{
			index++;
		}
		else if (option == "Exit")
		{
			done = true;
		}
	}
}

void UI::list_adoption_list()
{
	print_dogs(this->user_service.get_all_dogs_from_adoption_list());
}


//void UI::list_filtered_dogs_user()
//{
//	string given_breed, given_age;
//	int age = 0;
//	cout << "Enter the breed: ";
//	getline(cin, given_breed);
//	if (!string_validator(given_breed))
//	{
//		throw "The entered breed is not valid!";
//	}
//	cout << "Enter the age: ";
//	getline(cin, given_age);
//	if (!string_validator(given_age) && given_age.length() != 0)
//	{
//		age = stoi(given_age);
//	}
//	if ((int)age < 0)
//	{
//		throw "The entered age is not valid!";
//	}
//	auto* valid_dogs = new Dog[this->service->get_service_capacity()];
//	int length = this->user_service->get_filtered_dogs(valid_dogs, given_breed, age);
//	if (length == 0)
//	{
//		throw "There are no matching dogs!";
//	}
//	string option;
//	bool done = false;
//	int index = 0;
//	while (!done)
//	{
//		if (length == 0)
//		{
//			throw "There are no more dogs!";
//		}
//		if (index == length)
//		{
//			index = 0;
//		}
//		cout << valid_dogs[index].toString() << endl;
//		cout<< "Would you like to adopt dog? [Yes / No / Exit]" << endl;
//		string photo_link = string("start ").append(valid_dogs[index].get_photograph());
//		system(photo_link.c_str());
//		getline(cin, option);
//		if (option == "Yes")
//		{
//			Dog dog = valid_dogs[index];
//			this->user_service->add_user_service(dog);
//			for (int current_dog = index; current_dog < length - 1; current_dog++)
//			{
//				valid_dogs[current_dog] = valid_dogs[current_dog + 1];
//			}
//			length--;
//		}
//		else if (option == "No")
//		{
//			index++;
//		}
//		else if (option == "Exit")
//		{
//			done = true;
//		}
//	}
//
//}


//void UI::list_adoption_list()
//{
//	Dog* adoption_list = this->user_service->get_all_user_service();
//	int length = this->user_service->get_number_elements_user_service();
//	if (length == 0)
//	{
//		throw "There are no dogs in the adoption list!";
//	}
//	for (int current_dog_position = 0; current_dog_position < length; current_dog_position++)
//	{
//		cout << current_dog_position + 1 << "." << adoption_list[current_dog_position].toString() << endl;
//	}
//}

//UI::~UI() = default;
