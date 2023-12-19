import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

const sinkState = Variable({ volume: 0, muted: false });
const sourceState = Variable({ volume: 0, muted: false });

const updateSink = () => {
  Utils.execAsync('wpctl get-volume @DEFAULT_AUDIO_SINK@').then((output) => {
    const outputs = output.split(' ');
    const sinkVolume = parseFloat(outputs[1]) * 100;
    let sinkMuted;
    if (outputs.length > 2) {
      sinkMuted = true;
    } else {
      sinkMuted = false;
    }
    sinkState.setValue({ sinkVolume, sinkMuted });
  }).catch(print);
}

const updateSource = () => {
  Utils.execAsync('wpctl get-volume @DEFAULT_AUDIO_SOURCE@').then((output) => {
    const outputs = output.split(' ');
    const sourceVolume = parseFloat(outputs[1]) * 100;
    let sourceMuted;
    if (outputs.length > 2) {
      sourceMuted = true;
    } else {
      sourceMuted = false;
    }
    sourceState.setValue({ sourceVolume, sourceMuted });
  }).catch(print);
}

Variable({}, {
  listen: ['pactl subscribe', msg => {
    if (msg.includes('sink')) {
      updateSink();
    } else if (msg.includes('source')) {
      updateSource();
    }
  }]
});
updateSink();
updateSource();

const sinkIcon = () => Widget.Label({
  class_name: 'icon',
  binds: [['label', sinkState, 'value', ({ sinkMuted }) => {
    if (sinkMuted) {
      return '󰖁';
    }
    return '󰕾';
  }
  ]]
});

const sinkText = () => Widget.Label({
  binds: [['label', sinkState, 'value', ({ sinkVolume }) => {
    let formattedStr = sinkVolume.toFixed(0) + '%';
    formattedStr = formattedStr.padEnd(3, ' ');
    return formattedStr
  }
  ]]
});

const sourceIcon = () => Widget.Label({
  class_name: 'icon',
  binds: [['label', sourceState, 'value', ({ sourceMuted }) => {
    if (sourceMuted) {
      return '';
    }
    return '󰍬';
  }
  ]]
});

const sourceText = () => Widget.Label({
  binds: [['label', sourceState, 'value', ({ sourceVolume }) => {
    let formattedStr = sourceVolume.toFixed(0) + '%';
    formattedStr = formattedStr.padEnd(3, ' ');
    return formattedStr
  }
  ]]
});

const sinkLabel = () => Widget.EventBox({
  on_primary_click: () => {
    Utils.execAsync('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle').catch(print);
  },
  on_scroll_up: () => {
    Utils.execAsync('wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1').catch(print);
  },
  on_scroll_down: () => {
    Utils.execAsync('wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- -l 1').catch(print);
  },
  child: Widget.Box({
    class_name: 'sink',
    children: [sinkIcon(), sinkText()]
  })
});

const sourceLabel = () => Widget.EventBox({
  on_primary_click: () => {
    Utils.execAsync('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle').catch(print);
  },
  on_scroll_up: () => {
    Utils.execAsync('wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 2%+ -l 1').catch(print);
  },
  on_scroll_down: () => {
    Utils.execAsync('wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 2%- -l 1').catch(print);
  },
  child: Widget.Box({
    class_name: 'source',
    children: [sourceIcon(), sourceText()]
  })
});

const widget = () => Widget.Box({
  children: [
    sinkLabel(),
    sourceLabel()
  ]
});

export { widget, sinkLabel, sourceLabel };

