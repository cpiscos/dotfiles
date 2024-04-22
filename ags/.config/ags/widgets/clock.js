import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

const state = Variable({ date: '', time: '' });
const datePrefix = '';
const timePrefix = '';
// const datePrefix = '';
// const timePrefix = '';

Utils.interval(1000, () => {
  // date '+%a, %b %e  %I:%M:%S %p' | sed 's/  / /g'
  Utils.execAsync(['sh', '-c', 'date "+%a %b %e %l:%M:%S %p" | sed "s/  / /g"']).then((output) => {
    const datetime = String(output).split(' ');
    const dateStr = datetime[0] + ', ' + datetime[1] + ' ' + datetime[2];
    const timeStr = datetime[3] + ' ' + datetime[4];
    state.setValue({ date: dateStr, time: timeStr });
  }).catch((error) => {
    print(error);
  })
});

const dateIcon = () => Widget.Label({
  justification: 'center',
  class_name: 'icon',
  label: datePrefix,
});

const timeIcon = () => Widget.Label({
  justification: 'center',
  class_name: 'icon',
  label: timePrefix,
});

const dateText = () => Widget.Label({
  binds: [['label', state, 'value', ({ date }) => date]],
});

const timeText = () => Widget.Label({
  binds: [['label', state, 'value', ({ time }) => time]],
});

const dateWidget = () => Widget.Box({
  class_name: 'date',
  children: [dateIcon(), dateText()],
});

const timeWidget = () => Widget.Box({
  class_name: 'time',
  children: [timeIcon(), timeText()],
});

export { dateWidget, timeWidget };

