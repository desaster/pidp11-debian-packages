BIN = $(DESTDIR)/usr/bin
SHARE = $(DESTDIR)/usr/share/simh

ifndef DESTDIR
    $(error DESTDIR is not set)
endif

SIMH_SOURCE=../simh-repo

# install all binaries that appear in BIN/
install_bins : $(SIMH_SOURCE)/BIN/*
	for bin in $^; do \
	    install $${bin} $(BIN) ; \
	done

# install all files listed in sim_BuildROMs.c
install_roms :
	install -D -t $(SHARE)/VAX/ \
		$(SIMH_SOURCE)/VAX/ka655x.bin \
		$(SIMH_SOURCE)/VAX/ka620.bin \
		$(SIMH_SOURCE)/VAX/ka630.bin \
		$(SIMH_SOURCE)/VAX/ka610.bin \
		$(SIMH_SOURCE)/VAX/ka410.bin \
		$(SIMH_SOURCE)/VAX/ka411.bin \
		$(SIMH_SOURCE)/VAX/ka412.bin \
		$(SIMH_SOURCE)/VAX/ka41a.bin \
		$(SIMH_SOURCE)/VAX/ka41d.bin \
		$(SIMH_SOURCE)/VAX/ka42a.bin \
		$(SIMH_SOURCE)/VAX/ka42b.bin \
		$(SIMH_SOURCE)/VAX/ka43a.bin \
		$(SIMH_SOURCE)/VAX/ka46a.bin \
		$(SIMH_SOURCE)/VAX/ka47a.bin \
		$(SIMH_SOURCE)/VAX/ka48a.bin \
		$(SIMH_SOURCE)/VAX/is1000.bin \
		$(SIMH_SOURCE)/VAX/ka410_xs.bin \
		$(SIMH_SOURCE)/VAX/ka420_rdrz.bin \
		$(SIMH_SOURCE)/VAX/ka420_rzrz.bin \
		$(SIMH_SOURCE)/VAX/ka4xx_4pln.bin \
		$(SIMH_SOURCE)/VAX/ka4xx_8pln.bin \
		$(SIMH_SOURCE)/VAX/ka4xx_dz.bin \
		$(SIMH_SOURCE)/VAX/ka4xx_spx.bin \
		$(SIMH_SOURCE)/VAX/ka750_new.bin \
		$(SIMH_SOURCE)/VAX/ka750_old.bin \
		$(SIMH_SOURCE)/VAX/vcb02.bin \
		$(SIMH_SOURCE)/VAX/vmb.exe ; \
	install -D -t $(SHARE)/PDP11/ \
		$(SIMH_SOURCE)/PDP11/lunar11/lunar.lda \
		$(SIMH_SOURCE)/PDP11/dazzledart/dazzle.lda \
		$(SIMH_SOURCE)/PDP11/11logo/11logo.lda ; \
	install -D -t $(SHARE)/swtp6800/ $(SIMH_SOURCE)/swtp6800/swtp6800/swtbug.bin ; \
	install -D -t $(SHARE)/3B2/ $(SIMH_SOURCE)/3B2/rom_400.bin

install : install_bins install_roms

