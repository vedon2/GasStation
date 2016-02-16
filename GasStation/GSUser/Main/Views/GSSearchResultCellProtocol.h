//
//  GSSearchResultCellProtocol.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#ifndef GSSearchResultCellProtocol_h
#define GSSearchResultCellProtocol_h

@protocol GSSearchResultCellProtocol <NSObject>

+ (NSString *)cellIdentifier;

- (void)configureWithData:(id)data;

@optional
- (CGFloat)heightForCell;
@end

#endif /* GSSearchResultCellProtocol_h */
