# VerbaLex Voice
This folder are for scripts to generate train and test splits from the L2-Arctic dataset based on different
accents. There are also scripts to be used together with Huggingface hub to allow for a better experience 
when loading the dataset with the Huggingface transformers.

## File descriptions
### `accents.py`
This file defines the accents available within the dataset. The file will be imported by `verbalex_voice.py` 
to be used with Huggingface's dataset metadata.

### `release_stats.py`
This file defines the statistical overview of the dataset. The file will be imported by `verbalex_voice.py` 
to be used with Huggingface's dataset metadata.

### `verbalex_voice.py`
This file is the main file for creating the dataset upon loading, it defines all the needed functions and classes
needed when users load the dataset.
