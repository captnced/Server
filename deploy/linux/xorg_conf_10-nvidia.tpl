Section "ServerLayout"
    Identifier    "Layout0"
    Screen      0 "Screen0"
    InputDevice   "Generic Keyboard"
EndSection

Section "InputDevice"
    Identifier    "Generic Keyboard"
    Driver        "void"
    Option        "CoreKeyboard"
EndSection

Section "Module"
    Load           "dbe"
    Load           "extmod"
    Load           "type1"
    Load           "freetype"
    Load           "glx"
EndSection

Section "Monitor"
    Identifier     "Monitor0"
    VendorName     "Unknown"
    ModelName      "Unknown"
    HorizSync       28.0 - 33.0
    VertRefresh     43.0 - 72.0
    Option         "DPMS"
EndSection

Section "Device"
    Identifier     "Device0"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    BoardName      "Tesla M60"
    BusID          "%%BUSID%%"
EndSection

Section "Screen"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth    24
    #Option         "UseDisplayDevice" "None"
    SubSection     "Display"
        Virtual     1920 1080
        Depth       24
    EndSubSection
EndSection

