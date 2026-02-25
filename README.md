# Jashell

A lightweight desktop shell for [Niri](https://github.com/YaLTeR/niri) (Wayland compositor) written in QML using [Quickshell](https://github.com/quickshell/quickshell).

Jashell provides a minimal but functional shell with a top panel and sidebar, featuring workspace management, media controls, system monitoring, and theme support.

### Core Features
- Multi-monitor support with per-screen bars and sidebars
- Theme configuration with customizable colors
- Battery status monitoring
- Media player integration (MPRIS protocol)
- Workspace indicator and navigation

## Dependencies

- [Quickshell](https://github.com/quickshell/quickshell) - QML-based shell framework
- [Niri](https://github.com/YaLTeR/niri) - Wayland compositor
- [qml-niri](https://github.com/imiric/qml-niri) - QML bindings for Niri
- Qt 6.x (required by Quickshell)

## Installation
Clone this repository into your Quickshell configuration directory:
```bash
git clone <repo-url> ~/.config/quickshell/jashell
```

## Usage
Add `spawn-at-startup "quickshell -c jashell"` to your niri config.kdl.

## Configuration

Theme and colors can be configured via `config.json`. The configuration supports customization of:
- Background color
- Text color
- Accent colors (red, yellow, green)
- Icon color
- Icons

## Planned Features

- [ ] System tray support
- [ ] System monitoring widgets (CPU, memory, disk, network usage)
- [ ] i3_notify_bar integration
- [ ] Additional customization options

## License

See LICENSE file for details.
