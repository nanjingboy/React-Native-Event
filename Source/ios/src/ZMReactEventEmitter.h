#import <React/RCTBridge.h>

typedef void (^ReactEventEmitterCallbackHandler) (id data);

@interface ZMReactEventEmitter : NSObject

- (void)sendEvent:(RCTBridge *)bridge name:(NSString *)name;
- (void)sendEvent:(RCTBridge *)bridge name:(NSString *)name
           params:(id)params;
- (void)sendEvent:(RCTBridge *)bridge name:(NSString *)name
         callback:(ReactEventEmitterCallbackHandler)callback;
- (void)sendEvent:(RCTBridge *)bridge name:(NSString *)name
           params:(id)params
         callback:(ReactEventEmitterCallbackHandler)callback;

@end
