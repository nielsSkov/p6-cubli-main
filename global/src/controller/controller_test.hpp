/*
 * controller_test.hpp
 *
 *  Created on: 28/10/2014
 *      Author: benjaminkrebs
 */

#ifndef CONTROLLER_TEST_HPP_
#define CONTROLLER_TEST_HPP_

#include "controller_base.hpp"
#include <iostream>
#include "../bbb_gpio.hpp"
#include "../bbb_adc.hpp"

// Angle of the frame (in radians)
#ifndef THETA_REF
#define THETA_REF 0.0 
#endif

using namespace std;

class ControllerTest: public ControllerCbIf,public ControllerBase {
public:
	ControllerTest();
	~ControllerTest(){}

	static const char* getControllerNameStatic();
	static unsigned int getPeriodicityMusStatic();
	static ControllerBase* createController(string& name);


public: //Implementing ControllerCbIf
	unsigned int getPeriodicityMus();
	const char* getControllerName();
	void writeDebug();
	void runController(ControllerArgs* args);

private:
	string mControllerName;
};



#endif /* CONTROLLER_TEST_HPP_ */
