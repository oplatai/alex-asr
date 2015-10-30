KALDI_DIR = ../kaldi
FSTDIR=$(KALDI_DIR)/tools/openfst

all: py

include $(KALDI_DIR)/src/kaldi.mk

EXTRA_CXXFLAGS += -I$(KALDI_DIR)/src -Wno-sign-compare -I.

ADDLIBS = $(KALDI_DIR)/src/online2/kaldi-online2.a $(KALDI_DIR)/src/ivector/kaldi-ivector.a \
          $(KALDI_DIR)/src/nnet2/kaldi-nnet2.a $(KALDI_DIR)/src/lat/kaldi-lat.a \
          $(KALDI_DIR)/src/decoder/kaldi-decoder.a  $(KALDI_DIR)/src/cudamatrix/kaldi-cudamatrix.a \
          $(KALDI_DIR)/src/feat/kaldi-feat.a $(KALDI_DIR)/src/transform/kaldi-transform.a $(KALDI_DIR)/src/gmm/kaldi-gmm.a \
          $(KALDI_DIR)/src/thread/kaldi-thread.a $(KALDI_DIR)/src/hmm/kaldi-hmm.a $(KALDI_DIR)/src/tree/kaldi-tree.a \
          $(KALDI_DIR)/src/matrix/kaldi-matrix.a $(KALDI_DIR)/src/util/kaldi-util.a $(KALDI_DIR)/src/base/kaldi-base.a

OBJFILES = pykaldi2_decoder/pykaldi2_decoder.o pykaldi2_decoder/utils.o

LIBNAME = pykaldi2

include $(KALDI_DIR)/src/makefiles/default_rules.mk

py: $(LIBNAME).a
	CXXFLAGS="$(CXXFLAGS)" \
	PYKALDI_ADDLIBS="pykaldi2.a $(ADDLIBS)" \
	LIBRARY_PATH=$(FSTDIR)/lib:$(FSTDIR)/lib/fst CPLUS_INCLUDE_PATH=$(FSTDIR)/include \
	python setup.py build_ext


clean:
	rm -rf build
	rm $(LIBNAME).a lib$(LIBNAME).so
	rm $(OBJFILES)