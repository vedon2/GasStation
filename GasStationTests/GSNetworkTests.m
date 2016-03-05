//
//  GSNetworkTests.m
//  GasStation
//
//  Created by vedon on 3/3/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kTimeOut 10


#import <XCTest/XCTest.h>
#import "GSNetwork.h"
#import "GSUserProfileData.h"
#import "GSConsumeTicketData.h"
#import "YTKNetworkPrivate.h"
#import "GSCreateChargeTask.h"
#import "GSFetchCityGasStationTask.h"
#import "GSFetchCityGasStationData.h"
#import "GSFetchCoordinateGasStationTask.h"
#import "GSFetchCoordinateGasStationData.h"

@interface GSNetworkTests : XCTestCase
@property (strong,nonatomic) XCTestExpectation *expectation;
@end

@implementation GSNetworkTests

- (void)setUp {
    [super setUp];
    self.expectation = [self expectationWithDescription:@"CoursesViewModel"];
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
    
    GSRegisterTask *task = [[GSRegisterTask alloc] initWithPhone:@"15018492358" password:@"123456" veriCode:@"3885"];
    
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        [self.expectation fulfill];
        
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [self.expectation fulfill];
    }];
    
    
    [self waitForExpectationsWithTimeout:kTimeOut handler:^(NSError *error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
}



- (void)testLogin
{
    NSString *md5Pwd = [YTKNetworkPrivate md5StringFromString:@"123456"];
    GSLoginTask *task = [[GSLoginTask alloc] initWithPhone:@"15018492358" password:md5Pwd];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        [self.expectation fulfill];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
        [self.expectation fulfill];
        
    }];
    [self wait];
}

- (void)testGetSmsCode
{
    
    GSGetSmsCodeTask *task = [[GSGetSmsCodeTask alloc] initWithPhone:@"15018492358"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        [self.expectation fulfill];
    } failure:^(__kindof YTKBaseRequest *request) {
        [self.expectation fulfill];
    }];
    
    [self wait];
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

- (void)testCreateChargeId
{
    GSCreateChargeTask *task = [[GSCreateChargeTask alloc] initWithTargetId:@"2"];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        [self.expectation fulfill];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
        [self.expectation fulfill];
        
    }];
    [self wait];
    
}

- (void)testFetchCityGasStation
{
    GSFetchCityGasStationData *data = [[GSFetchCityGasStationData alloc] init];
    data.region = @"广州";
    data.q = @"加油";
    data.sortBy = @"distance:-1";
    data.pageSize = @"12";
    data.pageIndex = @"1";
    
    
    GSFetchCityGasStationTask *task = [[GSFetchCityGasStationTask alloc] initWithFetchData:data];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        [self.expectation fulfill];
    } failure:^(__kindof YTKBaseRequest *request) {
         [self.expectation fulfill];
    }];
}

- (void)testFetchCoordinateGasStation
{
    //116.405994,39.931978
    GSFetchCoordinateGasStationData *data = [[GSFetchCoordinateGasStationData alloc] initWithLocation:@"116.405994,39.931978" radius:@(100) sortBy:@"distance:-1" keyword:@"加油" pageIndex:@"1" pageSize:@"12"];
    GSFetchCoordinateGasStationTask *task = [[GSFetchCoordinateGasStationTask alloc] initWithFetchData:data];
    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        [self.expectation fulfill];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
        [self.expectation fulfill];
        
    }];
    
    [self wait];
}

//- (void)testLoginCookit
//{
//    NSString *md5Pwd = [YTKNetworkPrivate md5StringFromString:@"123456"];
//    GSLoginTask *task = [[GSLoginTask alloc] initWithPhone:@"15018492358" password:md5Pwd];
//    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        
//        GSCreateChargeTask *task = [[GSCreateChargeTask alloc] initWithTargetId:@"2"];
//        task.responseHeaders = @{@"version":@"1.0",@"cooket":@""};
//        [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//            
//            [self.expectation fulfill];
//            
//        } failure:^(__kindof YTKBaseRequest *request) {
//            
//            [self.expectation fulfill];
//            
//        }];
//        [self wait];
//        
//    } failure:^(__kindof YTKBaseRequest *request) {
//        
//        [self.expectation fulfill];
//        
//    }];
//    [self wait];
//}

- (void)wait
{
    [self waitForExpectationsWithTimeout:kTimeOut handler:^(NSError *error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
}



@end
