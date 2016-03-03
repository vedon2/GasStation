//
//  GSNetworkTests.m
//  GasStation
//
//  Created by vedon on 3/3/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GSNetwork.h"
#import "GSUserProfileData.h"
#import "GSConsumeTicketData.h"

@interface GSNetworkTests : XCTestCase

@end

@implementation GSNetworkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testRegister
{
    GSRegisterTask *task = [[GSRegisterTask alloc] initWithPhone:@"123" password:@"123" veriCode:@"123"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

- (void)testLogin
{
    GSLoginTask *task = [[GSLoginTask alloc] initWithPhone:@"123" password:@"123"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

- (void)testGetSmsCode
{
    GSGetSmsCodeTask *task = [[GSGetSmsCodeTask alloc] initWithPhone:@"123"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

- (void)testResetPwd
{
    GSResetPassworkTask *task = [[GSResetPassworkTask alloc] initWithNewPassword:@"123" oldPassword:@"123" veriCode:@"123" phone:@"123"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

- (void)testUpdateUserProfile
{
    GSUserProfileData *data = nil;
    GSUpdateUserProfileTask *task = [[GSUpdateUserProfileTask alloc] initWithProfileData:data userId:@"123"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

- (void)testComments
{
    GSFetchGasStationCommentsTask *task = [[GSFetchGasStationCommentsTask alloc] initWithStationId:@"123" pageSize:@"10" pageIndex:@"1"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

- (void)testConsumeCard
{
    GSConsumeTicketData *data = nil;
    GSConsumeTicketTask *task = [[GSConsumeTicketTask alloc] initWithConsumeData:data];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

- (void)testFetchCardList
{
    GSFetchCardListTask *task = [[GSFetchCardListTask alloc] initWithPageIndex:@"1" pageSize:@"10"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

- (void)testGetCardDetail
{
    GSGetCardDetailTask *task = [[GSGetCardDetailTask alloc] initWithCardId:@"123"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

- (void)testGetMyTask
{
    GSGetMyCardsTask *task = [[GSGetMyCardsTask alloc] initWithUserId:@"123" pageIndex:@"1" pageSize:@"10"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

- (void)testGetMyCardDetail
{
    GSGetMyCardDetailTask *task = [[GSGetMyCardDetailTask alloc] initWithCardId:@"123"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

- (void)testStartUp
{
    GSStartUpTask *task = [[GSStartUpTask alloc] initWithPlatform:@"" version:@"" edition:@""];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        ;
    } failure:^(__kindof YTKBaseRequest *request) {
        ;
    }];
}

@end
