import React from 'react';
import { StyleSheet, Button, View, NativeModules, Text } from 'react-native';
import ReactEventEmitter from 'rn-event-emitter-callback';
export default class App extends React.PureComponent {

  state = {
    nativeRequest: null,
  }

  _letNativeSendEvent = () => {
    NativeModules.RNEventDemoManager.sendEvent();
  }

  componentWillMount() {
    ReactEventEmitter.addListener('demo', (params, callback) => {
      this.setState({
        nativeRequest: params,
      });
      callback('Response from React Native');
    })
  }

  componentWillUnmount() {
    ReactEventEmitter.removeListener('demo');
  }

  render() {
    const { nativeRequest } = this.state;
    return (
      <View style={styles.container}>
        <Text style={styles.text}>{nativeRequest}</Text>
        <Button
          title='Click me let native send event'
          style={styles.button}
          onPress={this._letNativeSendEvent} />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  text: {
    fontSize: 16,
    fontWeight: 'bold',
    padding: 10,
  },
  button: {
    backgroundColor: 'gray',
    textAlign: 'center',
    padding: 10,
  },
});
