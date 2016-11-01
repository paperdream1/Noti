//
//  ContentParser.hpp
//  Noti
//
//  Created by 이채원 on 2016. 10. 19..
//  Copyright © 2016년 이채원. All rights reserved.
//

#ifndef ContentParser_hpp
#define ContentParser_hpp

#include <stdio.h>
#import <iostream>

using namespace std;

class ContentParser
{
public:
    string target;
    ContentParser(string target);
    string* parser(void);
};

#endif /* ContentParser_hpp */
