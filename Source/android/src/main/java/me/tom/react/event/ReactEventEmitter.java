package me.tom.react.event;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.HashMap;

import javax.annotation.Nullable;

public class ReactEventEmitter {

    private static final String sEventNamePrefix = "react_event_emitter";

    private HashMap<String, ReactEventEmitterCallbackHandler> mEventCallbackHandlers;

    public ReactEventEmitter() {
        mEventCallbackHandlers = new HashMap<>();
        EventBus.getDefault().register(this);
    }

    public void sendEvent(ReactContext context, String name) {
        sendEvent(context, name, null, null);
    }

    public void sendEvent(ReactContext context, String name, @Nullable Object params) {
        sendEvent(context, name, params, null);
    }

    public void sendEvent(ReactContext context,
                          String name,
                          @Nullable ReactEventEmitterCallbackHandler callbackHandler) {
        sendEvent(context, name, null, callbackHandler);
    }

    public void sendEvent(ReactContext context,
                          String name,
                          @Nullable Object params,
                          @Nullable ReactEventEmitterCallbackHandler callbackHandler) {
        WritableMap args = Arguments.createMap();
        String eventName = sEventNamePrefix + "_" + name;
        String callbackId = eventName + "_" + System.currentTimeMillis();
        if (callbackHandler != null) {
            args.putString("callbackId", callbackId);
            mEventCallbackHandlers.put(callbackId, callbackHandler);
        } else {
            args.putNull("callbackId");
        }
        DeviceEventManagerModule.RCTDeviceEventEmitter emitter = context.getJSModule(
                DeviceEventManagerModule.RCTDeviceEventEmitter.class
        );
        if (params instanceof Boolean) {
            args.putBoolean("params", (Boolean) params);
        } else if (params instanceof Integer) {
            args.putInt("params", (Integer) params);
        } else if (params instanceof Float) {
            args.putDouble("params", ((Float) params).doubleValue());
        } else if (params instanceof Double) {
            args.putDouble("params", (Double) params);
        } else if (params instanceof String) {
            args.putString("params", (String) params);
        } else if (params instanceof WritableArray) {
            args.putArray("params", (WritableArray) params);
        } else if (params instanceof WritableMap) {
            args.putMap("params", (WritableMap) params);
        } else {
            args.putNull("params");
        }
        emitter.emit(eventName, args);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void onReactCallbackEvent(ReactEventEmitterCallbackEvent event) {
        if (mEventCallbackHandlers.containsKey(event.callBackId)) {
           mEventCallbackHandlers.get(event.callBackId).handler(event.data);
           mEventCallbackHandlers.remove(event.callBackId);
        }
    }

    @Override
    protected void finalize() throws Throwable {
        super.finalize();
        EventBus.getDefault().unregister(this);
    }
}
