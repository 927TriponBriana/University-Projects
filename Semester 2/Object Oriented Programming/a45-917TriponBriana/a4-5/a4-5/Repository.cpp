#include "Repository.h"


Repository::~Repository() = default;

void Repository::initialise_repository()
{
	Dog dog1 = Dog("Labrador", "Leila", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	Dog dog2 = Dog("German Shepherd", "Bruno", 12, "http://www.zooland.ro/data/articles/39/652/2005421143847lup-0n.jpg");
	Dog dog3 = Dog("Akita", "Thor", 5, "https://s3.publi24.ro/vertical-ro-f646bd5a/extralarge/20190815/1351/fadb271780baa1710c1b2b7708635aa3.jpg");
	Dog dog4 = Dog("Husky", "Kaya", 3, "https://extrucan.ro/wp-content/uploads/2021/08/Siberian-Husky.jpg");
	Dog dog5 = Dog("Golden", "Athos", 6, "https://www.animalepierdute.ro/wp-content/uploads/2019/08/golden-retriver-caine-de-rasa.jpg");
	Dog dog6 = Dog("Chow chow", "Nala", 3, "https://www.perfectdogbreeds.com/wp-content/uploads/2020/04/Chow-Chow-What-to-Know-Before-Buying-Cover.jpg");
	Dog dog7 = Dog("Rottweiler", "Max", 9, "https://www.animaland.ro/wp-content/uploads/2022/03/rott1-1200x900.jpg");
	Dog dog8 = Dog("Beagel", "Rex", 7, "https://www.zooplus.ro/ghid/wp-content/uploads/2021/07/caine-beagle-768x512.jpeg");
	Dog dog9 = Dog("Teckel", "Norris", 6, "https://upload.wikimedia.org/wikipedia/commons/2/27/Short-haired-Dachshund.jpg");
	Dog dog10 = Dog("Poodle", "Milo", 2, "https://image.petmd.com/files/styles/863x625/public/2023-01/toy-poodle.jpg?w=1920&q=75");

	add_to_repository(dog1);
	add_to_repository(dog2);
	add_to_repository(dog3);
	add_to_repository(dog4);
	add_to_repository(dog5);
	add_to_repository(dog6);
	add_to_repository(dog7);
	add_to_repository(dog8);
	add_to_repository(dog9);
	add_to_repository(dog10);
}

void Repository::add_to_repository(const Dog& dog)
{
	
	this->Dogs.add_element(dog);
}

void Repository::delete_from_repository(const string& breed, const string& name)
{
	int dog_position = find_position_by_breed_and_name(breed, name);
	this->Dogs.delete_element(dog_position);
}

void Repository::update_repository(const string& breed, const string& name, const Dog& new_dog)
{
	int dog_position = find_position_by_breed_and_name(breed, name);
	this->Dogs.update_element(dog_position, new_dog);
}

int Repository::get_number_of_elements()
{
	return this->Dogs.get_size();
}

int Repository::get_repository_capacity()
{
	return this->Dogs.get_capacity();
}

int Repository::find_position_by_breed_and_name(const string breed, const string name)
{
	if (this->Dogs.get_size() == 0)
	{
		return -1;
	}
	int length = this->get_number_of_elements();
	int position = -1;
	for (int current_position = 0; current_position < length; current_position++)
	{
		Dog dog = this->Dogs.get_element(current_position);
		if (dog.get_breed() == breed && dog.get_name() == name)
		{
			position = current_position;
		}
	}
	return position;
}
