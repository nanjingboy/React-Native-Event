package com.rneventdemo;

import android.os.Bundle;
import android.widget.Toast;

import com.facebook.react.ReactActivity;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReadableMap;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import me.tom.react.event.ReactEventEmitter;
import me.tom.react.event.ReactEventEmitterCallbackHandler;

public class MainActivity extends ReactActivity {

    private ReactEventEmitter mReactEventEmitter;

    @Override
    protected String getMainComponentName() {
        return "RNEventDemo";
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mReactEventEmitter = new ReactEventEmitter();
    }

    @Override
    protected void onStart() {
        super.onStart();
        EventBus.getDefault().register(this);
    }

    @Override
    protected void onStop() {
        super.onStop();
        EventBus.getDefault().unregister(this);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void onRNEventDemoEvent(RNEventDemoEvent event) {
        ReactContext context = getReactInstanceManager().getCurrentReactContext();
        mReactEventEmitter.sendEvent(context, "demo", "Request from Native", new ReactEventEmitterCallbackHandler() {
            @Override
            public void handler(ReadableMap data) {
                Toast.makeText(MainActivity.this, data.getString("data"), Toast.LENGTH_SHORT).show();
            }
        });
    }
}
