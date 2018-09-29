package me.tom.react.event;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

import org.greenrobot.eventbus.EventBus;

public class ReactEventEmitterManager extends ReactContextBaseJavaModule {

    public ReactEventEmitterManager(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "ReactEventEmitterManager";
    }

    @ReactMethod
    public void invokeCallback(String callbackId, ReadableMap data) {
        ReactEventEmitterCallbackEvent callbackEvent = new ReactEventEmitterCallbackEvent();
        callbackEvent.callBackId = callbackId;
        callbackEvent.data = data;
        EventBus.getDefault().post(callbackEvent);
    }
}
