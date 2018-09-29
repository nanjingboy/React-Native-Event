package com.rneventdemo;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import org.greenrobot.eventbus.EventBus;

public class RNEventDemoManager extends ReactContextBaseJavaModule {

    public RNEventDemoManager(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "RNEventDemoManager";
    }

    @ReactMethod
    public void sendEvent() {
        EventBus.getDefault().post(new RNEventDemoEvent());
    }
}
