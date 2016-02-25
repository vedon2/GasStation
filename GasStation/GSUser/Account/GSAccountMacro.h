//
//  GSAccountMacro.h
//  GasStation
//
//  Created by vedon on 2/25/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#ifndef GSAccountMacro_h
#define GSAccountMacro_h

//#define kAccountDebugMode 1


#ifdef DEBUG
#define EnableGSLog 1
#endif

#ifdef EnableGSLog
#define GSLog NSLog
#else
#define GSLog(...)
#endif


#endif /* GSAccountMacro_h */
