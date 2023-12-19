import { Widget } from 'resource:///com/github/Aylur/ags/widget.js';
import * as DateTime from './widgets/clock.js';
import * as IdleInhib from './widgets/idle_inhibitor.js';
import * as Hyprland from './widgets/hyprland.js';
import * as SystemInfo from './widgets/system.js';
import * as SoundInfo from './widgets/sound.js';
import App from 'resource:///com/github/Aylur/ags/app.js'
import { exec } from 'resource:///com/github/Aylur/ags/utils.js'

const Bar = (/** @type {number} */ monitor) => Widget.Window({
  monitor,
  name: `bar${monitor}`,
  anchor: ['top', 'left', 'right'],
  exclusivity: 'normal',
  child: Widget.CenterBox({
    start_widget: Widget.Box({
      class_name: 'start-widget',
      hpack: 'start',
      children: [
        Hyprland.Workspaces(monitor), 
        Hyprland.focusedTitle(monitor)],
    }),
    center_widget: Widget.Box({
      class_name: 'center-widget',
      hpack: 'center',
      children: [
        DateTime.timeWidget(),
      ],
    }),
    end_widget: Widget.Box({
      class_name: 'end-widget',
      hpack: 'end',
      children: [
        IdleInhib.widget(), 
        SoundInfo.sinkLabel(),
        SoundInfo.sourceLabel(),
        SystemInfo.cpuLabel(), 
        SystemInfo.memoryLabel(), 
        SystemInfo.diskLabel(),
        DateTime.dateWidget(), 
      ],
    })
  })
})

const scss = `${App.configDir}/style.scss`
const css = `${App.configDir}/style.css`
exec(`sassc ${scss} ${css}`)

export default {
  windows: [Bar(0), Bar(1)],
  style: css,
}
