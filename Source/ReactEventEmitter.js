import { NativeModules, DeviceEventEmitter } from 'react-native';

const eventNamePrefix = 'react_event_emitter';
const { ReactEventEmitterManager } = NativeModules;

const addListener = (name, handler) => {
  DeviceEventEmitter.addListener(`${eventNamePrefix}_${name}`, ({ callbackId, params }) => {
    handler(params, (data) => {
      if (callbackId !== null) {
        ReactEventEmitterManager.invokeCallback(
          callbackId,
          { data },
        );
      }
    });
  });
};

const removeListener = (name) => {
  DeviceEventEmitter.removeListener(`${eventNamePrefix}_${name}`);
};

export default {
  addListener,
  removeListener,
}