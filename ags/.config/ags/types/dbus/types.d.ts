/// <reference types="@girs/gio-2.0/gio-2.0-ambient" />
/// <reference types="@girs/gtk-3.0/node_modules/@girs/gio-2.0/gio-2.0-ambient" />
/// <reference types="@girs/nm-1.0/node_modules/@girs/gio-2.0/gio-2.0-ambient" />
/// <reference types="@girs/glib-2.0/glib-2.0-ambient" />
/// <reference types="@girs/gtk-3.0/node_modules/@girs/glib-2.0/glib-2.0-ambient" />
/// <reference types="@girs/gtk-3.0/node_modules/@girs/harfbuzz-0.0/node_modules/@girs/glib-2.0/glib-2.0-ambient" />
import GLib from 'node_modules/@girs/glib-2.0/glib-2.0';
import Gio from 'node_modules/@girs/gio-2.0/gio-2.0';
export interface DBusProxy extends Gio.DBusProxy {
    new (...args: unknown[]): DBusProxy;
    ListNamesRemote: (callback: (names: string[][]) => void) => void;
}
export interface PlayerProxy extends Gio.DBusProxy {
    new (...args: unknown[]): PlayerProxy;
    CanControl: boolean;
    CanGoNext: boolean;
    CanGoPrevious: boolean;
    CanPlay: boolean;
    CanPause: boolean;
    Metadata: {
        [key: string]: GLib.Variant;
    };
    PlaybackStatus: string;
    Shuffle: boolean | null;
    LoopStatus: string | null;
    Volume: number;
    Position: number;
    SetPositionAsync: (trackid: string, position: number) => void;
    PlayPauseAsync: () => Promise<void>;
    NextAsync: () => Promise<void>;
    PreviousAsync: () => Promise<void>;
    StopAsync: () => Promise<void>;
    PlayAsync: () => Promise<void>;
}
export interface MprisProxy extends Gio.DBusProxy {
    new (...args: unknown[]): MprisProxy;
    Raise: () => void;
    Quit: () => void;
    CanQuit: boolean;
    CanRaise: boolean;
    Identity: string;
    DesktopEntry: string;
}
export interface BatteryProxy extends Gio.DBusProxy {
    new (...args: unknown[]): BatteryProxy;
    State: number;
    Percentage: number;
    IsPresent: boolean;
    TimeToEmpty: number;
    TimeToFull: number;
    Energy: number;
    EnergyFull: number;
    EnergyRate: number;
}
export interface StatusNotifierItemProxy extends Gio.DBusProxy {
    new (...args: unknown[]): StatusNotifierItemProxy;
    Category: string;
    Id: string;
    Title: string;
    Status: string;
    WindowId: number;
    IconThemePath: string;
    ItemIsMenu: boolean;
    Menu: string;
    IconName: string;
    IconPixmap: [number, number, Uint8Array][];
    AttentionIconName: string;
    AttentionIconPixmap: [number, number, Uint8Array][];
    ToolTip: [string, [number, number, Uint8Array], string, string];
    ContextMenuAsync: (x: number, y: number) => Promise<void>;
    ActivateAsync: (x: number, y: number) => Promise<void>;
    SecondaryActivateAsync: (x: number, y: number) => Promise<void>;
    ScrollAsync: (delta: number, orientation: string) => Promise<void>;
}
export interface AgsProxy extends Gio.DBusProxy {
    new (...args: unknown[]): AgsProxy;
    InspectorRemote: () => void;
    QuitRemote: () => void;
    ToggleWindowSync: (name: string) => boolean;
    RunFileRemote: (js: string, busName?: string, objPath?: string) => void;
    RunJsRemote: (js: string, busName?: string, objPath?: string) => void;
    RunPromiseRemote: (js: string, busName?: string, objPath?: string) => void;
}
export interface StatusNotifierItemProxy extends Gio.DBusProxy {
    new (...args: unknown[]): StatusNotifierItemProxy;
    Category: string;
    Id: string;
    Title: string;
    Status: string;
    WindowId: number;
    IconThemePath: string;
    ItemIsMenu: boolean;
    Menu: string;
    IconName: string;
    IconPixmap: [number, number, Uint8Array][];
    AttentionIconName: string;
    AttentionIconPixmap: [number, number, Uint8Array][];
    ToolTip: [string, [number, number, Uint8Array], string, string];
    ContextMenuAsync: (x: number, y: number) => Promise<void>;
    ActivateAsync: (x: number, y: number) => Promise<void>;
    SecondaryActivateAsync: (x: number, y: number) => Promise<void>;
    ScrollAsync: (delta: number, orientation: string) => Promise<void>;
}
