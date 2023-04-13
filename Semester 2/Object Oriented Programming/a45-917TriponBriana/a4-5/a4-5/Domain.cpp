#include "Domain.h"

Dog::Dog(string breed, string name, int age, string photograph)
{
	//Constructor method for the Dog class
	if (age < 0)
	{
		throw "The age must be greater than 0!";
	}
	this->breed = breed;
	this->name = name;
	this->age = age;
	this->photograph = photograph;
}

string Dog::get_breed() const
{
	//Getter method for the breed
	return this->breed;
}

string Dog::get_name() const
{
	//Getter method for the name
	return this->name;
}

int Dog::get_age() const
{
	//Getter method for the age
	return this->age;
}

string Dog::get_photograph() const
{
	//Getter method for the photograph
	return this->photograph;
}

void Dog::set_breed(string new_breed)
{
	//Setter method for the breed
	this->breed = new_breed;
}

void Dog::set_name(string new_name)
{
	//Setter method for the name
	this->name = new_name;
}

void Dog::set_age(int new_age)
{
	//Setter method for the age
	this->age = new_age;
}

void Dog::set_photograph(string new_photograph)
{
	//Setter method for the photograph
	this->photograph = new_photograph;
}

string Dog::toString()
{
	//Method to format an entity into a string
	return "Breed: " + this->breed + " | Name: " + this->name + " | Age: " + to_string(this->age) + " | Photograph: " + this->photograph;
}

//Destructor of the class
Dog::~Dog() = default;
