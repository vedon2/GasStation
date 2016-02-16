//
//  GSUserManagerProtocol.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#ifndef GSUserManagerProtocol_h
#define GSUserManagerProtocol_h

@protocol GSUserManagerProtocol <NSObject>

- (NSArray *)currentVisitor;

- (NSArray *)currentChatterList;


@end

#endif /* GSUserManagerProtocol_h */
