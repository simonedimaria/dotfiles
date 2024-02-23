import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
//const hyprland = await Service.import("hyprland");
//import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
//import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import FloatingDock from './dock/FloatingDock.js';

//const date = Variable('', {
//    poll: [1000, 'date'],
//});

//const Bar = () => Widget.Window({
//    child: Widget.Label().bind('label', date),
//});
const MyButton = () => Widget.Button()
    .on('clicked', self => {
        print(self, 'is clicked')
    })

const BatteryPercent = () => Label()
    .hook(Battery, self => {
        self['label'] = `${Battery.percent}%`
        self['visible'] = Battery.available
    }, 'notify::percent')

const batteryProgress = Widget.CircularProgress({
    value: Battery.bind('percent').transform(p => p / `${p}%`),
    child: Widget.Icon({
        icon: Battery.bind('icon_name'),
    }),
});

// LEFT LAYOUT
const Workspaces = () => Widget.Box({
    class_name: 'workspaces',
    children: Hyprland.bind('workspaces').transform(ws => {
        return ws.map(({ id }) => Widget.Button({
            on_clicked: () => Hyprland.sendMessage(`dispatch workspace ${id}`),
            child: Widget.Label(`${id}`),
            class_name: Hyprland.active.workspace.bind('id')
                .transform(i => `${i === id ? 'focused' : ''}`),
        }));
    }),
});

const ClientTitle = () => Widget.Label({
    class_name: 'client-title',
    label: Hyprland.active.client.bind('title'),
});

const Clock = () => Widget.Label({
    class_name: 'clock',
    setup: self => self.poll(1000, self => execAsync(['date', '+%H:%M:%S %a %d %b'])
            .then(date => self.label = date)),
});

// MIDDLE LAYOUT
/*const Media = () => Widget.Button({
    class_name: 'media',
    on_primary_click: () => Mpris.getPlayer('')?.playPause(),
    on_scroll_up: () => Mpris.getPlayer('')?.next(),
    on_scroll_down: () => Mpris.getPlayer('')?.previous(),
    child: Widget.Label('-').hook(Mpris, self => {
        if (Mpris.players[0]) {
            const { track_artists, track_title } = Mpris.players[0];
            self.label = `${track_artists.join(', ')} - ${track_title}`;
        } else {
            self.label = 'Nothing is playing';
        }
    }, 'player-changed'),
});

const Notification = () => Widget.Box({
    class_name: 'notification',
    visible: Notifications.bind('popups').transform(p => p.length > 0),
    children: [
        Widget.Icon({
            icon: 'preferences-system-notifications-symbolic',
        }),
        Widget.Label({
            label: Notifications.bind('popups').transform(p => p[0]?.summary || ''),
        }),
    ],
});*/

// RIGHT LAYOUT
const Volume = () => Widget.Box({
    class_name: 'volume',
    css: 'min-width: 180px',
    children: [
        Widget.Icon().hook(Audio, self => {
            if (!Audio.speaker)
                return;

            const category = {
                101: 'overamplified',
                67: 'high',
                34: 'medium',
                1: 'low',
                0: 'muted',
            };

            const icon = Audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
                threshold => threshold <= Audio.speaker.volume * 100);

            self.icon = `audio-volume-${category[icon]}-symbolic`;
        }, 'speaker-changed'),
        Widget.Slider({
            hexpand: true,
            draw_value: false,
            on_change: ({ value }) => Audio.speaker.volume = value,
            setup: self => self.hook(Audio, () => {
                self.value = Audio.speaker?.volume || 0;
            }, 'speaker-changed'),
        }),
    ],
});

const BatteryLabel = () => Widget.Box({
    class_name: 'battery',
    visible: Battery.bind('available'),
    children: [
        Widget.Icon({
            icon: Battery.bind('percent').transform(p => {
                return `battery-level-50-symbolic`;
            }),
        }),
        Widget.ProgressBar({
            vpack: 'center',
            fraction: Battery.bind('percent').transform(p => {
                return p > 0 ? p / 100 : 0;
            }),
        }),
    ],
});

const SysTray = () => Widget.Box({
    children: SystemTray.bind('items').transform(items => {
        return items.map(item => Widget.Button({
            child: Widget.Icon({ binds: [['icon', item, 'icon']] }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            binds: [['tooltip-markup', item, 'tooltip-markup']],
        }));
    }),
});

// layout of the bar
const Left = () => Widget.Box({
    hpack: 'start',
    spacing: 15, // space in px between each children
    children: [
        Workspaces(),
        //ClientTitle(),
    ],
});

const Center = () => Widget.Box({
    spacing: 8,
    children: [
        //Media(),
        //Notification(),
        ClientTitle(),
    ],
});

const Right = () => Widget.Box({
    hpack: 'end',
    spacing: 15,
    children: [
       Volume(),
       BatteryLabel(),
       Clock(),
       SysTray(),
    ],
});

const TopBar = (monitor=0) => Widget.Window({
    monitor,
    class_name: 'topbar',
    name: `bar-${monitor}`,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    focusable: false,
    layer: 'top',
    margins: [0, 0],
    //opacity: 1.0
    child: Widget.CenterBox({
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(),
    }), 
//Widget.Label().bind('label', date),
});
import { monitorFile } from 'resource:///com/github/Aylur/ags/utils.js';
// main scss file
//const scss = `${App.configDir}/scss/main.scss`;
// target css file
const css = `${App.configDir}/style.css`;
//monitorFile(
//    scss,
//    function() {
//        exec(`sassc ${scss} ${css}`);
//        App.resetCss();
//        App.applyCss(`${App.configDir}/style.css`);
//    },
//);


export default {
	style: css,
	notificationPopupTimeout: 5000,
	notificationForceTimeout: false,
	cacheNotificationActions: false,
	//cacheCoverArt: true,
	windows: [
		TopBar(),
		FloatingDock(),
	],
};
