import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Dock from './Dock.js';
import options from '../options.js';


/** @param {number} monitor */
export default (monitor=0) => {
    let timeoutId;
    const revealer = Widget.Revealer({
        transition: 'slide_up',
        child: Dock(),
        setup: self => {
            const update = () => {
                const ws = Hyprland.getWorkspace(Hyprland.active.workspace.id);
                if (Hyprland.getMonitor(monitor)?.name === ws?.monitor)
                    self.reveal_child = ws?.windows === 0;
            };
            self
                .hook(Hyprland, update, 'client-added')
                .hook(Hyprland, update, 'client-removed')
                .hook(Hyprland.active.workspace, update);
        },
    });

    return Widget.Window({
        monitor,
        name: `dock-${monitor}`,
        class_name: 'floating-dock',
        anchor: ['bottom'],
        child: Widget.Box({
            children: [
                revealer,
                Widget.Box({
                    class_name: 'padding',
                    css: 'padding: 2px;',
                }),
            ],
        }),
        setup: self => self
            // The ::enter-notify-event will be emitted when the pointer enters the widget‘s window.
            .on('enter-notify-event', () => {
                timeoutId.destroy();
                revealer.reveal_child = true;
            })
            // The ::leave-notify-event will be emitted when the pointer leaves the widget‘s window.            
            .on('leave-notify-event', () => {
                timeoutId = setTimeout(() => {
                // wait 2s before hiding dock
                revealer.reveal_child = false;
                revealer.child.children[1].children.forEach(
                    button => {
                        const icon = button.child.child.child; // @TODO: better way to get icon
                        icon.toggleClassName('clicked', false);
                });
              }, 2000)
            })
            .bind('visible', options.bar.position, 'value', v => v !== 'bottom'),
    });
};

