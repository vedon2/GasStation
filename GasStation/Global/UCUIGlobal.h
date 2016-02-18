
#import <UIKit/UIKit.h>

enum
{
    E35inchDisplayType,
    E4inchDisplayType,
    E47inchDisplayType,
    E55inchDisplayType,
    
    
    EUnuseDiaplayType,
};

typedef int DeviceDisplayType;

@interface UCUIGlobal : NSObject


+ (CGSize)portraitScreenSize;
+ (CGSize)landscapeScreenSize;

+ (BOOL)is35inchDisplay;
+ (BOOL)is4inchDisplay;
+ (BOOL)is47inchDisplay;
+ (BOOL)is55inchDisplay;

+ (UIWindow *)applicationWindow;

+ (DeviceDisplayType)deviceDisplayType;

+ (BOOL)isPortraitScreen;    ///< 是否竖屏
+ (CGFloat)getStatusHeight;
+ (CGRect)deviceScreenBounds; ///< 实时获取真实设备朝向的screenBounds


@end
