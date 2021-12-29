package main

import (
	"github.com/kermieisinthehouse/systray"
	"github.com/kopia/ui-shell/icons"
)

func main() {
	systray.Run(onReady, onExit)
}

func onReady() {
	systray.SetIcon(icons.TrayIcon)

	//systray.SetTitle("KopiaUI")
	systray.SetTooltip("KopiaUI")
	systray.AddMenuItem("<starting up>", "Starting up...")
	systray.AddMenuItem("<starting up>", "Starting up...")
	systray.AddSeparator()
	systray.AddMenuItem("Connect To Another Repository...", "")
	systray.AddSeparator()
	mLaunchAtStartup := systray.AddMenuItemCheckbox("Launch At Startup", "Automatically launch at startup", false)
	mQuit := systray.AddMenuItem("Quit", "Quit the whole app")

	go func() {
		for {
			select {
			case <-mQuit.ClickedCh:
				systray.Quit()
				return

			case <-mLaunchAtStartup.ClickedCh:
				if mLaunchAtStartup.Checked() {
					mLaunchAtStartup.Uncheck()
				} else {
					mLaunchAtStartup.Check()
				}
			}
		}
	}()
}

func onExit() {
	// clean up here
}
