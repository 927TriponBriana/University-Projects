#pragma once
#include <iostream>
#include <cstring>
#include <string>

using namespace std;

class Dog
{
private:
	string breed;
	string name;
	int age;
	string photograph;

public:
	Dog(string breed = "empty", string name = "empty", int age = 0, string photograph = "empty");
	string get_breed() const;
	string get_name() const;
	int get_age() const;
	string get_photograph() const;

	void set_breed(string new_breed);
	void set_name(string new_name);
	void set_age(int new_age);
	void set_photograph(string new_photograph);

	string toString();

	~Dog();
};