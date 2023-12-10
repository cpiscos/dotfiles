import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import { Widget } from 'resource:///com/github/Aylur/ags/widget.js';
import App from 'resource:///com/github/Aylur/ags/app.js'
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js'

const idleInhibitorPrefix = '';
const activatedText = '';
const deactivatedText = '';

const idleInhibitor = Variable({ state: '0' }, {
  listen: [App.configDir + '/widgets/idle_inhibitor.sh', msg => ({ state: msg })]
})

const label = () => Widget.Label({
  class_name: 'icon',
  binds: [['label', idleInhibitor, 'value', 
    (value) => idleInhibitorPrefix + (value.state === '1' ? activatedText : deactivatedText)]],
});

const widget = () => Widget.EventBox({
  class_name: 'idle_inhibitor',
  on_primary_click: () => {
    Utils.execAsync(App.configDir + '/widgets/toggle_idle_inhibit.sh').catch(print);
  },
  child: label()
})

export { widget };
