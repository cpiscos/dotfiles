import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';

const cpuPrefix = '';
const memoryPrefix = '';
const diskPrefix = '󰋊';
const decimalPlaces = 1;

const cpuState = Variable({ state: '0' }, {
  poll: [1000, ["sh", "-c", "mpstat | awk '/all/ {print $13}'"], msg => ({ state: (100-parseFloat(msg))})]
});

const memoryState = Variable({ state: '0' }, {
  poll: [1000, ["sh", "-c", "free -m | awk '/Mem/ {print $3/$2 * 100.0}'"], msg => ({ state: parseFloat(msg) })]
});

const diskState = Variable({ state: '0' }, {
  poll: [1000, ["sh", "-c", "df -h | awk '/^\\/dev/ {print($5); exit}' | sed 's/\%//'"], msg => ({ state: parseFloat(msg) })]
});

const cpuIcon = () => Widget.Label({
  justification: 'center',
  class_name: 'icon',
  label: cpuPrefix,
});

const memoryIcon = () => Widget.Label({
  justification: 'center',
  class_name: 'icon',
  label: memoryPrefix,
});

const diskIcon = () => Widget.Label({
  justification: 'center',
  class_name: 'icon',
  label: diskPrefix,
});

const cpuText = () => Widget.Label({
  binds: [['label', cpuState, 'value', ({ state }) => state.toFixed(decimalPlaces) + '%']],
});

const memoryText = () => Widget.Label({
  binds: [['label', memoryState, 'value', ({ state }) => state.toFixed(decimalPlaces) + '%']],
});

const diskText = () => Widget.Label({
  binds: [['label', diskState, 'value', ({ state }) => state.toFixed(decimalPlaces) + '%']],
});

const cpuLabel = () => Widget.Box({
  class_name: 'cpu',
  children: [cpuIcon(), cpuText()],
});

const memoryLabel = () => Widget.Box({
  class_name: 'memory',
  children: [memoryIcon(), memoryText()],
});

const diskLabel = () => Widget.Box({
  class_name: 'disk',
  children: [diskIcon(), diskText()],
});

export { cpuLabel, memoryLabel, diskLabel };
