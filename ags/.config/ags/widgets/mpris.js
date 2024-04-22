import Widget from 'resource:///com/github/Aylur/ags/widget.js';
// import Variable from 'resource:///com/github/Aylur/ags/variable.js';

// const Mpris = Variable({
//   msg: 'mpris',
// }, {
//   'listen': ["dbus-monitor --session interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',path='/org/mpris/MediaPlayer2'",
//     msg => {
//       print(msg);
//     }],
//   // 'listen': ["pactl subscribe",
//   //   msg => {
//   //     print(msg);
//   //   }],
// });
  // 'listen': [["dbus-monitor", "--session \"interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',path='/org/mpris/MediaPlayer2'\""], 

import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
// import App from 'resource:///com/github/Aylur/ags/app.js'

// Mpris.connect('changed', item => print(JSON.stringify(item)));

// print(App.config);

const currentlyPlaying = () => Widget.Button({
  onClicked: () => Mpris.players[0]?.playPause(),
  child: Widget.Label(),
  visible: false,
  connections: [[Mpris, self => {
    print(JSON.stringify(Mpris.players));
    print(Mpris.players);
    const player = Mpris.players[0];
    print(player);
    self.visible = player;
    if (!player)
      return;

    const { trackArtists, trackTitle } = player;
    self.child.label = `${trackArtists.join(', ')} - ${trackTitle}`;
  }]],
});

export { currentlyPlaying };

