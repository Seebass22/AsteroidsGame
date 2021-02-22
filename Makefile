GAME_NAME = asteroids

default: linux

all: linux html5 windows

build_dir:
	@mkdir -p build/$(GAME_NAME)-linux
	@mkdir -p build/$(GAME_NAME)-windows
	@mkdir -p build/$(GAME_NAME)-html5

linux: build_dir
	godot --export "Linux/X11" build/$(GAME_NAME)-linux/$(GAME_NAME)

windows: build_dir
	godot --export "Windows Desktop" build/$(GAME_NAME)-windows/$(GAME_NAME).exe

html5: build_dir
	godot --export "HTML5" build/$(GAME_NAME)-html5/index.html

itch:
	butler push build/asteroids-linux/ seebass22/asteroids:linux-x86_64
	butler push build/asteroids-windows/ seebass22/asteroids:windows-x86_64
	butler push build/asteroids-html5/ seebass22/asteroids:html5
