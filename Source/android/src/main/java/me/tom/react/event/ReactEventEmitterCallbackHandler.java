package me.tom.react.event;

import com.facebook.react.bridge.ReadableMap;

public interface ReactEventEmitterCallbackHandler {

    void handler(ReadableMap data);
}
