//
//  GSMapMacro.h
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#ifndef GSMapMacro_h
#define GSMapMacro_h

#ifdef DEBUG
#define EnableGSLog 1
#endif


#ifdef EnableGSLog
#define GSLog NSLog
#else
#define GSLog NSLog(...)
#endif

#endif /* GSMapMacro_h */
