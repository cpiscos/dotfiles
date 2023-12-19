import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

const persistentWorkspace = {
  'DP-1': [1, 2, 3, 4, 5],
  'DP-2': [6, 7, 8, 9, 10]
};

const classToIcon = {
  'kitty': '',
  'Alacritty': '',
  'brave-browser': '󰖟',
  'com.obsproject.Studio': '󰯜',
  'neovide': '',
  'firefox': '',
};

const titleReplacements = {
  ' — Brave': '',
  ' — Mozilla Firefox': '',
};

async function init() {
  while (!Hyprland.monitors || Hyprland.monitors.length === 0) {
    await new Promise(resolve => setTimeout(resolve, 100));
  }
}

const states = Object.keys(persistentWorkspace).reduce(
  (obj, monitor) => ({ ...obj, [monitor]: Variable({ class: '', title: 'Hyprland', address: '0x' }) }), {}
);

function updateActiveLabels() {
  if (Hyprland.active.client.address === '') return;
  const workspace = Hyprland.getWorkspace(Hyprland.active.workspace.id);
  const monitor = Hyprland.monitors.find(monitor => Hyprland.active.monitor === monitor.name);
  if (!workspace) {
    states[monitor.name].setValue({ class: '', title: 'Hyprland', address: '0x' });
    return;
  }
  if (states[workspace.monitor].value.address === Hyprland.active.client.address
    && states[workspace.monitor].value.title === Hyprland.active.client.title) return;
  if (Hyprland.active.monitor !== workspace.monitor) { print('monitor not match'); return; }
  if (Hyprland.active.client.address === '0x') {
    states[workspace.monitor].setValue({ class: '', title: 'Hyprland', address: '0x' });
    return;
  } else {
    const client = Hyprland.getClient(Hyprland.active.client.address);
    if (!client) return;
    if (client.monitor !== workspace.monitorID) { print('client monitor not match'); return; }
    states[workspace.monitor].setValue(client);
  }
};

function initLabels() {
  Hyprland.monitors.forEach(monitor => {
    const workspace = Hyprland.getWorkspace(monitor.activeWorkspace.id);
    if (['0x0', '0x'].includes(workspace.lastwindow)) {
      return;
    }
    const client = Hyprland.getClient(workspace.lastwindow);
    states[monitor.name].setValue(client);
  });
}


Hyprland.connect('changed', service => {
  updateActiveLabels();
});

await init();
initLabels();


const focusedTitleIcon = (monitor) => Widget.Label({
  // class_name: 'icon',
  label: '',
  binds: [['label', states[Hyprland.monitors[monitor].name], 'value', value => {
    if (value.class in classToIcon) {
      return classToIcon[value.class];
    } else if (value.class === '') {
      return value.class;
    } else {
      return value.class + ': ';
    }
  }],
    ['class_name', states[Hyprland.monitors[monitor].name], 'value', value => {
      if (value.class in classToIcon) {
        return 'icon';
      } else {
        return '';
      }
    }
  ]],
});

const focusedTitleText = (monitor) => Widget.Label({
  label: '',
  binds: [['label', states[Hyprland.monitors[monitor].name], 'value', value => {
    for (const [key, val] of Object.entries(titleReplacements)) {
      if (value.title.includes(key)) {
        return value.title.replace(key, val);
      }
    }
    return value.title
  }]],
});

const focusedTitle = (monitor) => Widget.Box({
  class_name: 'focused-title',
  children: [focusedTitleIcon(monitor), focusedTitleText(monitor)],
});

const dispatch = ws => Utils.execAsync(`hyprctl dispatch workspace ${ws}`);

const Workspaces = (monitor) => Widget.EventBox({
  on_scroll_up: () => dispatch('+1'),
  on_scroll_down: () => dispatch('-1'),
  child: Widget.Box({
    children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
      label: '',
      class_name: 'workspace-button fa-regular',
      setup: btn => btn.id = i,
      on_clicked: () => dispatch(i),
    })),

    connections: [[Hyprland, box => box.children.forEach(btn => {
      if (!Hyprland.monitors[monitor]) return;
      if (!btn.monitorName) {
        btn.monitorName = Hyprland.monitors[monitor].name;
      }
      btn.visible = persistentWorkspace[btn.monitorName].includes(btn.id);
      if (btn.id === Hyprland.monitors[monitor].activeWorkspace.id) {
        btn.toggleClassName('active', true);
        btn.label = '';
      } else {
        btn.toggleClassName('active', false);
        btn.label = '';
      }
    })],
    ],
  }),
});

export { focusedTitle, Workspaces };
