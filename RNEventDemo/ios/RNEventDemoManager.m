#import "RNEventDemoManager.h"

@implementation RNEventDemoManager

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue {
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(sendEvent) {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"RNEventDemoManager" object:nil];
}

@end
