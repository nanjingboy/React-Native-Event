#import <React/RCTEventEmitter.h>
#import "ZMReactEventEmitter.h"

@interface ZMReactEventEmitter()

@property(nonatomic, strong) NSMutableDictionary *callbackHandlers;

@end

@implementation ZMReactEventEmitter

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(subscribeEventEmitterManager:)
                                                     name:@"ZMReactEventEmitterManager"
                                                   object:nil];
    }
    return self;
}

- (NSMutableDictionary *)callbackHandlers {
    if (_callbackHandlers == nil) {
        _callbackHandlers = [NSMutableDictionary new];
    }
    return _callbackHandlers;
}

- (void)sendEvent:(RCTBridge *)bridge name:(NSString *)name {
    [self sendEvent:bridge name:name params:nil callback:nil];
}

- (void)sendEvent:(RCTBridge *)bridge name:(NSString *)name
           params:(id)params {
    [self sendEvent:bridge name:name params:params callback:nil];
}

- (void)sendEvent:(RCTBridge *)bridge name:(NSString *)name
         callback:(ReactEventEmitterCallbackHandler)callback {
    [self sendEvent:bridge name:name params:nil callback:callback];
}

- (void)sendEvent:(RCTBridge *)bridge name:(NSString *)name
           params:(id)params
         callback:(ReactEventEmitterCallbackHandler)callback {
    
    NSMutableDictionary *args = [NSMutableDictionary new];
    NSString *eventName = [NSString stringWithFormat:@"react_event_emitter_%@", name];
    NSString *callbackId = [NSString stringWithFormat:@"%@_%f", eventName, [[NSDate date] timeIntervalSince1970]];
    if (callback != nil) {
        args[@"callbackId"] = callbackId;
        self.callbackHandlers[callbackId] = callback;
    } else {
        args[@"callbackId"] = [NSNull null];
    }
    if (params == nil) {
        args[@"params"] = [NSNull null];
    } else {
        args[@"params"] = params;
    }
    [bridge enqueueJSCall:@"RCTDeviceEventEmitter"
                   method:@"emit"
                     args:@[eventName, args]
               completion:nil];
}

- (void)subscribeEventEmitterManager:(NSNotification *)notification {
    NSDictionary *args = [notification object];
    NSString *callbackId = args[@"callbackId"];
    ReactEventEmitterCallbackHandler callback = self.callbackHandlers[callbackId];
    if (callback != nil) {
        callback(args[@"data"]);
        [self.callbackHandlers removeObjectForKey:callbackId];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:@"ZMReactEventEmitterManager"];
}

@end
