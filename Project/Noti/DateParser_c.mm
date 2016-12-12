//
//  DateParser_c.m
//  Noti
//
//  Created by 이채원 on 2016. 12. 12..
//  Copyright © 2016년 이채원. All rights reserved.
//
/*
#import <Foundation/Foundation.h>
#include <vector>
#include <map>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <iostream>

using namespace std;


class Date{
public:
    int year;
    int month;
    int date;
    int day;
    int hour;
    int minute;
    
    Date(){
        t = time(NULL);
        datetime = localtime(&t);
        year = datetime->tm_year + 1900;
        month = datetime->tm_mon + 1;
        date = datetime->tm_mday;
        hour = datetime->tm_hour;
        minute = datetime->tm_min;
        day = datetime->tm_wday;//0 = sunday
    }
    
private:
    struct tm* datetime;
    time_t t;
};


class Parser
{
public:
    map<string, double> weightArr;
    vector<pair<string, string>> num;
    map<string, int> timeTok;
    
    Parser()
    {
        weightArr.insert(make_pair("화", 5));
        weightArr.insert(make_pair("수", 5));
        weightArr.insert(make_pair("목", 5));
        weightArr.insert(make_pair("금", 5));
        weightArr.insert(make_pair("토", 5));
        weightArr.insert(make_pair("월", 5));
        weightArr.insert(make_pair("/", 5));
        weightArr.insert(make_pair("다음주", 5));
        weightArr.insert(make_pair(":", 5));
        weightArr.insert(make_pair(".", 5));
        
        weightArr.insert(make_pair("년", 15));
        weightArr.insert(make_pair("월", 18));
        weightArr.insert(make_pair("일", 10));
        weightArr.insert(make_pair("오늘", 15));
        weightArr.insert(make_pair("저녁", 10));
        weightArr.insert(make_pair("낮", 10));
        weightArr.insert(make_pair("아침", 10));
        weightArr.insert(make_pair("점심", 10));
        weightArr.insert(make_pair("시", 17));
        weightArr.insert(make_pair("분", 17));
        
        
        num.push_back(make_pair("오십일", "51"));
        num.push_back(make_pair("오십일", "51"));
        num.push_back(make_pair("오십이", "52"));
        num.push_back(make_pair("오십삼", "53"));
        num.push_back(make_pair("오십사", "54"));
        num.push_back(make_pair("오십오", "55"));
        num.push_back(make_pair("오십육", "56"));
        num.push_back(make_pair("오십칠", "57"));
        num.push_back(make_pair("오십팔", "58"));
        num.push_back(make_pair("오십구", "59"));
        num.push_back(make_pair("오십", "50"));
        num.push_back(make_pair("사십일", "41"));
        num.push_back(make_pair("사십이", "42"));
        num.push_back(make_pair("사십삼", "43"));
        num.push_back(make_pair("사십사", "44"));
        num.push_back(make_pair("사십오", "45"));
        num.push_back(make_pair("사십육", "46"));
        num.push_back(make_pair("사십칠", "47"));
        num.push_back(make_pair("사십팔", "48"));
        num.push_back(make_pair("사십구", "49"));
        num.push_back(make_pair("사십", "40"));
        num.push_back(make_pair("삼십일", "31"));
        num.push_back(make_pair("삼십이", "32"));
        num.push_back(make_pair("삼십삼", "33"));
        num.push_back(make_pair("삼십사", "34"));
        num.push_back(make_pair("삼십오", "35"));
        num.push_back(make_pair("삼십육", "36"));
        num.push_back(make_pair("삼십칠", "37"));
        num.push_back(make_pair("삼십팔", "38"));
        num.push_back(make_pair("삼십구", "39"));
        num.push_back(make_pair("삼십", "30"));
        num.push_back(make_pair("이십일", "21"));
        num.push_back(make_pair("이십이", "22"));
        num.push_back(make_pair("이십삼", "23"));
        num.push_back(make_pair("이십사", "24"));
        num.push_back(make_pair("이십오", "25"));
        num.push_back(make_pair("이십육", "26"));
        num.push_back(make_pair("이십칠", "27"));
        num.push_back(make_pair("이십팔", "28"));
        num.push_back(make_pair("이십구", "29"));
        num.push_back(make_pair("이십", "20"));
        num.push_back(make_pair("십일", "11"));
        num.push_back(make_pair("십이", "12"));
        num.push_back(make_pair("십삼", "13"));
        num.push_back(make_pair("십사", "14"));
        num.push_back(make_pair("십오", "15"));
        num.push_back(make_pair("십육", "16"));
        num.push_back(make_pair("십칠", "17"));
        num.push_back(make_pair("십팔", "18"));
        num.push_back(make_pair("십구", "19"));
        num.push_back(make_pair("십", "10"));
        num.push_back(make_pair("열두", "12"));
        num.push_back(make_pair("열한", "11"));
        num.push_back(make_pair("한", "1"));
        num.push_back(make_pair("두", "2"));
        num.push_back(make_pair("세", "3"));
        num.push_back(make_pair("네", "4"));
        num.push_back(make_pair("다섯", "5"));
        num.push_back(make_pair("여섯", "6"));
        num.push_back(make_pair("일곱", "7"));
        num.push_back(make_pair("여덟", "8"));
        num.push_back(make_pair("아홉", "9"));
        num.push_back(make_pair("열", "10"));
        num.push_back(make_pair("이", "2"));
        num.push_back(make_pair("삼", "3"));
        num.push_back(make_pair("사", "4"));
        num.push_back(make_pair("오", "5"));
        num.push_back(make_pair("육", "6"));
        num.push_back(make_pair("칠", "7"));
        num.push_back(make_pair("팔", "8"));
        num.push_back(make_pair("구", "9"));
        num.push_back(make_pair("일", "1"));
        
        timeTok.insert(make_pair("분", 0));
        timeTok.insert(make_pair("시", 1));
        timeTok.insert(make_pair("일", 2));
        timeTok.insert(make_pair("월", 3));
        timeTok.insert(make_pair("년", 4));
        timeTok.insert(make_pair(".", 5));
        timeTok.insert(make_pair(":", 6));
        timeTok.insert(make_pair("-", 7));
        timeTok.insert(make_pair("/", 8));
        
    }
    
    string convertNumber(string &target)
    {
        string result = target;
        
        for(pair<string, string> item : num){
            result = replaceAll(result, item.first, item.second);
        }
        
        return result;
    }
    
    string replaceAll(const string &str, const string &pattern, const string &replace)
    {
        string result = str;
        string::size_type pos = 0;
        string::size_type offset = 0;
        
        while((pos = result.find(pattern, offset)) != string::npos)
        {
            if(!(result.c_str()[pos-1] >= '0' && result.c_str()[pos-1] <= '9')){
                result.replace(result.begin() + pos, result.begin() + pos + pattern.size(), replace);
            }
            offset = pos + replace.size();
            
        }
        
        return result;
        
    }
    
    vector<string> stringTokenizer(string &str)
    {
        
        vector<string> result;
        
        char *convertedStr = (char*)malloc(sizeof(char)*str.size());
        strcpy(convertedStr, str.c_str());
        
        char *context = NULL;
        char *temp = strtok_r(convertedStr, " ", &context);
        
        while(temp != NULL)
        {
            result.push_back(temp);
            temp = strtok_r(NULL, " ", &context);
        }
        return result;
    }
    
    double* computeWeight(vector<string> str)
    {
        double *result = (double*)malloc(sizeof(double)*str.size());
        
        for(int k=0;k<str.size();k++) // 그래프 전체를 순회하면서 계산된 가중치를 합산
        {
            result[k] = 0;
        }
        
        
        for(pair<string, double> item : weightArr) // 키워드 데이터베이스를 순회하며 키워드를 하나씩 검색
        {
            string::size_type pos = 0;
            
            
            for(int i=0;i<str.size();i++) // 모든 단어를 순회하며 검사
            {
                
                if((pos = str[i].find(item.first, 0)) != string::npos) // 단어가 키워드를 포함하는지를 검사
                {
                    if(strcmp(item.first.c_str(), "시") == 0 || strcmp(item.first.c_str(), "분") == 0)
                    {
                        if(pos == 0 || str[i][pos-1] < '0' || str[i][pos-1] >'9'){
                            continue;
                        }
                    }
                    if(strcmp(item.first.c_str(), ":") == 0 || strcmp(item.first.c_str(), "/") == 0){
                        if(pos == 0 || pos == str[i].length() - 1 || str[i][pos-1] < '0' || str[i][pos-1] >'9' || str[i][pos+1] < '0' || str[i][pos+1] >'9')
                        {
                            continue;
                        }
                    }
                    //cout << str[i] << endl;
                    for(int k=0;k<str.size();k++) // 그래프 전체를 순회하면서 계산된 가중치를 합산
                    {
                        result[k]+= expConvert(item.second, i-k);
                        //cout << result[k] << " " << k << endl;
                    }
                }
            }
            
        }
        
        return result;
    }
    
    double expConvert(double weight,int offset)
    {
        double density = 2;
        int offsetSqr = offset*offset;
        
        double menti = -offsetSqr/(density*density);
        
        //cout << weight << " " << weight*exp(menti) << " " << exp(menti) << endl;
        
        return weight*exp(menti);
    }
    
    string parseDate(vector<string> temp){
        
        double *temp1 = computeWeight(temp);
        Date *datetime = new Date();
        vector<int> date;
        
        for(int i=0; i<temp.size(); i++){
            //cout << temp1[i] << " " << temp[i] << endl;
            
            if(temp1[i] >= 18.0){
                date.push_back(i);
            }
        }
        
        for(pair<string, int> tok : timeTok){
            
            for(int i=0; i<date.size(); i++){
                string::size_type pos = 0;
                if((pos = temp[date[i]].find(tok.first, 0)) != string::npos) // 단어가 키워드를 포함하는지를 검사
                {
                    if(pos >= 2){
                        
                        switch (tok.second) {
                            case 0:{
                                int minute = temp[date[i]][pos-1] - '0';
                                if(minute >=0 && minute <=9){
                                    if( (temp[date[i]][pos-2] > '0' && temp[date[i]][pos-2] <= '6')){
                                        minute += (temp[date[i]][pos-2] - '0') * 10;
                                    }
                                    datetime->minute = minute;
                                } else {
                                    datetime->minute = 0;
                                }
                                break;
                            }
                            case 1:{
                                int hour = temp[date[i]][pos-1] - '0';
                                if(hour >=0 && hour <=9){
                                    if( (temp[date[i]][pos-2] > '0' && temp[date[i]][pos-2] <= '2')){
                                        hour += (temp[date[i]][pos-2] - '0') * 10;
                                    }
                                    datetime->hour = hour;
                                }
                                break;
                            }
                            case 2:{
                                int dat = temp[date[i]][pos-1] - '0';
                                if(dat >=0 && dat <=9){
                                    if( (temp[date[i]][pos-2] > '0' && temp[date[i]][pos-2] <= '3')){
                                        dat += (temp[date[i]][pos-2] - '0') * 10;
                                    }
                                    datetime->date = dat;
                                }
                                break;
                            }
                            case 3:{
                                cout << 1 <<endl;
                                int month = temp[date[i]][pos-1] - '0';
                                if(month >=0 && month <=9){
                                    if( temp[date[i]][pos-2] == '1'){
                                        month += (temp[date[i]][pos-2] - '0') * 10;
                                    }
                                    datetime->month = month;
                                }
                                break;
                            }
                                
                            case 4:{
                                int year = temp[date[i]][pos-1] - '0';
                                if(year >=0 && year <=9){
                                    if( (temp[date[i]][pos-2] > '0' && temp[date[i]][pos-2] <= '9')){
                                        year += (temp[date[i]][pos-2] - '0') * 10;
                                    }
                                    datetime->year = 2000 + year;
                                }
                                break;
                            }
                            case 5:
                            case 7:
                            case 8:{
                                int item = (temp[date[i]][pos - 2] - '0') * 10 + (temp[date[i]][pos - 1] - '0');
                                bool isyear = false;
                                if(item > 12 && item < 99){
                                    datetime->year = 2000+ item;
                                    isyear = true;
                                } else if(item >= 10 && item <= 12){
                                    datetime->month = item;
                                } else if(temp[date[i]][pos - 1] - '0' >= 1 && temp[date[i]][pos - 1] - '0' <= 9){
                                    datetime->month = temp[date[i]][pos - 1] - '0';
                                } else{
                                    break;
                                }
                                
                                int item1 = (temp[date[i]][pos + 1] - '0') * 10 + (temp[date[i]][pos + 2] - '0');
                                if(temp[date[i]].length() > pos + 2){
                                    if(item1 > 0 && item1 <= 31){
                                        if(isyear && item1 >= 1 && item1 <= 12){
                                            datetime->month = item1;
                                        } else {
                                            datetime->date = item1;
                                        }
                                    }
                                } else if(temp[date[i]].length() == pos + 1){
                                    if(temp[date[i]][pos + 1] > '0' && temp[date[i]][pos + 1] <= '9'){
                                        if(isyear){
                                            datetime->month = temp[date[i]][pos + 1];
                                        } else {
                                            datetime->date = temp[date[i]][pos + 1];
                                        }
                                    }
                                }
                                
                                if(isyear){
                                    int item2 = (temp[date[i]][pos + 3] - '0') * 10 + (temp[date[i]][pos + 4] - '0');
                                    if(tok.first.length() > pos + 4){
                                        if(item2 > 0 && item2 <= 31){
                                            datetime->date = item2;
                                        }
                                    } else if(tok.first.length() == pos + 3){
                                        if(temp[date[i]][pos + 3] > '0' && temp[date[i]][pos + 3] <= '9'){
                                            datetime->date = temp[date[i]][pos + 3];
                                        }
                                    }
                                }
                                break;
                            }
                                
                                
                                
                                
                        }
                    } else if(pos  == 1){
                        switch (tok.second) {
                            case 0:
                                datetime->minute = temp[date[i]][0] - '0';
                                
                                break;
                            case 1:
                                datetime->hour = temp[date[i]][0] - '0';
                                break;
                            case 2:
                                datetime->date = temp[date[i]][0] - '0';
                                
                                break;
                            case 3:
                                datetime->month = temp[date[i]][0] - '0';
                                
                                break;
                                
                                
                            default:
                                break;
                        }
                    }
                }
            }
        }
        string result = "";
        result.append(to_string(datetime->year)).append(".").append(to_string(datetime->month)).append(".").append(to_string(datetime->date)).append(" ").append(to_string(datetime->hour)).append(":").append(to_string(datetime->month));
        return result;
    }
};*/
