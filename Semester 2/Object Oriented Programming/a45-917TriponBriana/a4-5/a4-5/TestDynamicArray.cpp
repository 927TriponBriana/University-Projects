#include "TestDynamicArray.h"
#include <cassert>
#include <cstring>

void test_dynamicArray()
{
	auto* dynamicArray = new DynamicArray<TElement>(1);
	assert(dynamicArray->get_capacity() == 1);
	assert(dynamicArray->get_size() == 0);
	/*try
	{
		auto* invalid_dynamicArray = new DynamicArray<TElement>(0);
	}
	catch (const char* message)
	{
		assert(strcmp(message, "Incorrect capacity!") == 0);
	}*/
	TElement element = nullptr;
	dynamicArray->add_element(element);
	assert(dynamicArray->get_size() == 1);
	TElement new_element = nullptr;
	dynamicArray->add_element(new_element);
	assert(dynamicArray->get_size() == 2);
	assert(dynamicArray->get_capacity() == 2);
	TElement given_element = nullptr;
	dynamicArray->update_element(1, given_element);
	//assert(dynamicArray->get_element()[1] == given_element);
	TElement input_element = nullptr;
	dynamicArray->add_element(input_element);
	dynamicArray->delete_element(1);
	assert(dynamicArray->get_size() == 2);
}
