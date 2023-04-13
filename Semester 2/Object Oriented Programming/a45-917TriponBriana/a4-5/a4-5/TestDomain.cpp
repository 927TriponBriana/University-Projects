#include "TestDomain.h"
#include <cassert>
#include <cstring>

void test_domain()
{
	Dog new_dog("Maltipoo", "Milo", 1, "https://www.hepper.com/wp-content/uploads/2022/11/maltipoo-lying-on-a-dog-bed_OlgaOvcharenko_Shutterstock.jpg");
	assert(new_dog.get_breed() == "Maltipoo");
	assert(new_dog.get_name() == "Milo");
	assert(new_dog.get_age() == 1);
	assert(new_dog.get_photograph() == "https://www.hepper.com/wp-content/uploads/2022/11/maltipoo-lying-on-a-dog-bed_OlgaOvcharenko_Shutterstock.jpg");
	auto age_string = to_string(new_dog.get_age());
	string string = new_dog.toString();
	assert(string == "Breed: Maltipoo | Name: Milo | Age: 1 | Photograph: https://www.hepper.com/wp-content/uploads/2022/11/maltipoo-lying-on-a-dog-bed_OlgaOvcharenko_Shutterstock.jpg");
	/*try
	{
		Dog invalid_dog("Labrador", "Rex", -1, "https://www");
	}
	catch (const char* message)
	{
		assert(strcmp(message, "Age cannot be smaller than 0!") == 0);
	}*/
}
