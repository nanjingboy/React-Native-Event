#import "ZMReactEventEmitterManager.h"

@implementation ZMReactEventEmitterManager

RCT_EXPORT_MODULE(ReactEventEmitterManager);

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(invokeCallback:(NSString *)callbackId data:(NSDictionary *)data) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZMReactEventEmitterManager"
                                                        object:@{@"callbackId": callbackId, @"data": data}];
}

@end

