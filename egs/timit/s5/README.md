# Acoustic Feature and Transcript Extraction from the Kaldi data format

[Kaldi](http://kaldi-asr.org) has made use of special data preparation where audio and lingustic data are utilized for training. In order to use these data for other systems, we extract acoustic features (MFCC 39th, log Mel filter bank 40th, and log Mel filter bank 120th) and transcriptions. It is written for TIMIT corpus but not limited to others if available.

## Kaldi installation

Follow the installation information [HERE](http://kaldi-asr.org/doc/install.html).

## TIMIT corpus configuration

Define the location of TIMIT corpus in [run_feat_extract.sh](https://github.com/homink/kaldi/blob/FeatureText/egs/timit/s5/run_feat_extract.sh) and [onmt/build_tgt.sh](https://github.com/homink/kaldi/blob/FeatureText/egs/timit/s5/onmt/build_tgt.sh).
