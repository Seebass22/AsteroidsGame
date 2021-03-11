GAME_NAME = asteroids

all: linux html5 windows osx

build_dir:
	@mkdir -p build/$(GAME_NAME)-linux
	@mkdir -p build/$(GAME_NAME)-windows
	@mkdir -p build/$(GAME_NAME)-html5
	@mkdir -p build/$(GAME_NAME)-osx

icon:
	convert -background transparent icon.png -define icon:auto-resize=16,32,64,256 icon.ico

linux: build_dir
	godot --export "Linux/X11" build/$(GAME_NAME)-linux/$(GAME_NAME)

windows: build_dir icon
	godot --export "Windows Desktop" build/$(GAME_NAME)-windows/$(GAME_NAME).exe

osx: build_dir
	godot --export "Mac OSX" build/$(GAME_NAME)-osx/$(GAME_NAME)-osx.zip

html5: build_dir
	godot --export "HTML5" build/$(GAME_NAME)-html5/index.html

itch:
	butler push build/asteroids-linux/ seebass22/asteroids:linux-x86_64
	butler push build/asteroids-windows/ seebass22/asteroids:windows-x86_64
	butler push build/asteroids-html5/ seebass22/asteroids:html5
	butler push build/asteroids-osx/ seebass22/asteroids:osx
