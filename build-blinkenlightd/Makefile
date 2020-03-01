BIN=$(DESTDIR)/usr/bin
SHARE=$(DESTDIR)/usr/share/simh
BB_SOURCE=../blinkenbone-repo

ifndef BIN_ARCH
    $(error BIN_ARCH is not set)
endif

ifndef DESTDIR
    $(error DESTDIR is not set)
endif

install : $(BB_SOURCE)/projects/11_pidp_server/pidp11/$(BIN_ARCH)/pidp1170_blinkenlightd
	install -m 755 $^ $(BIN)
