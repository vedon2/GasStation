//
//  GSBaseRequestMockProtocol.h
//  GasStation
//
//  Created by vedon on 2/24/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#ifndef GSBaseRequestMockProtocol_h
#define GSBaseRequestMockProtocol_h

@protocol GSBaseRequestMockProtocol <NSObject>

- (BOOL)enableMock;

- (id)mockData;

- (NSInteger)responseStatusCode;

@end

#endif /* GSBaseRequestMockProtocol_h */
