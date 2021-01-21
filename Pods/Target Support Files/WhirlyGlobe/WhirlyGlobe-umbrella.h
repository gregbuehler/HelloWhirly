#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GlobeTapMessage.h"
#import "MaplyComponent.h"
#import "MaplySharedAttributes.h"
#import "WhirlyGlobe-Maply-Umbrella.h"
#import "WhirlyGlobeComponent.h"
#import "MapboxVectorInterpreter.h"
#import "MapboxVectorTiles.h"
#import "lodepng.h"

FOUNDATION_EXPORT double WhirlyGlobeVersionNumber;
FOUNDATION_EXPORT const unsigned char WhirlyGlobeVersionString[];

