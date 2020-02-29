import React from 'react';
import { AppRegistry, StyleSheet, SafeAreaView, FlatList, Text, View, Image } from 'react-native';

function StatusIcon({ stateAbbr }) {
  switch (stateAbbr) {
    case "c": return (
      <Image
        style={{ width: 20, height: 20 }}
        source={require("./assets/c.png")}
      />
    )
    case "h": return (
      <Image
        style={{ width: 20, height: 20 }}
        source={require("./assets/h.png")}
      />
    )

    case "hc": return (
      <Image
        style={{ width: 20, height: 20 }}
        source={require("./assets/hc.png")}
      />
    )

    case "hr": return (
      <Image
        style={{ width: 20, height: 20 }}
        source={require("./assets/hr.png")}
      />
    )

    case "lc": return (
      <Image
        style={{ width: 20, height: 20 }}
        source={require("./assets/lc.png")}
      />
    )

    case "lr": return (
      <Image
        style={{ width: 20, height: 20 }}
        source={require("./assets/lr.png")}
      />
    )

    case "s": return (
      <Image
        style={{ width: 20, height: 20 }}
        source={require("./assets/s.png")}
      />
    )

    case "sl": return (
      <Image
        style={{ width: 20, height: 20 }}
        source={require("./assets/sl.png")}
      />
    )

    case "sn": return (
      <Image
        style={{ width: 20, height: 20 }}
        source={require("./assets/sn.png")}
      />
    )

    default: return (
      <Image
        style={{ width: 20, height: 20 }}
        source={require("./assets/t.png")}
      />
    )

  }
}

function Weather({ state }) {
  if (!state.weather_state_abbr) {
    return
  }
  var createdDate = new Date(state.created);
  var image = state.weather_state_abbr ? "./assets/" + state.weather_state_abbr + ".png" : "./assets/c.png"
  return (
    <View style={styles.item}>
      <View style={styles.column}>
        <View>
          <Text style={styles.text}>{createdDate.toLocaleDateString()}</Text>
        </View>
        <View>
          <Text style={styles.text}>{createdDate.toLocaleTimeString()}</Text>
        </View>
      </View>
      <View style={styles.column}>
        <StatusIcon stateAbbr={state.weather_state_abbr}/>
        <Text style={styles.text}>{state.weather_state_name}</Text>
      </View>
      <View style={styles.column}>
        <View>
          <Text style={styles.text}>{Math.round(state.min_temp)} C</Text>
        </View>
        <View>
          <Text style={styles.text}>{Math.round(state.max_temp)} C</Text>
        </View>
      </View>
      <View style={styles.column}>
        <View>
          <Text style={styles.humidity}>Humidity</Text>
        </View>
        <View>
          <Text style={styles.text}>{state.humidity} %</Text>
        </View>
      </View>
    </View>
  );
};
class RNWeather extends React.Component {

  render() {
    return (
      <SafeAreaView style={styles.container}>
        <FlatList
          data={this.props.data}
          renderItem={({ item }) => <Weather state={item} />}
        />
      </SafeAreaView>
    );
  }
}
const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 5,
  },
  item: {
    flexDirection: 'row',
    borderBottomColor: '#000000',
    borderBottomWidth: 1,
    marginVertical: 5,
  },
  column: {
    flex: 1,
    padding: 5,
  },
  text: {
    fontSize: 12,
    textAlign: 'center'
  },
  humidity: {
    fontSize: 12,
    fontWeight: "700"
  }
});

// Module name
AppRegistry.registerComponent('RNWeather', () => RNWeather);
