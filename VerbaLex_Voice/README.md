# VerbaLex Voice
This folder are for scripts to generate train and test splits from the L2-Arctic dataset based on different
accents. There are also scripts to be used together with Huggingface hub to allow for a better experience 
when loading the dataset with the Huggingface transformers.

It is also worth noting that the loading scripts in this directory will not automatically build a Dataset Viewer on
Huggingface's dataset card. See [this GitHub issue](https://github.com/huggingface/datasets-server/issues/2385#issuecomment-2017614189)
for more information.

## File descriptions
### `accents.py`
This file defines the accents available within the dataset. The file will be imported by `verbalex_voice.py` 
to be used with Huggingface's dataset metadata.

### `release_stats.py`
This file defines the statistical overview of the dataset. The file will be imported by `verbalex_voice.py` 
to be used with Huggingface's dataset metadata.

### `VerbaLex_voice.py`
This file is the main file for creating the dataset upon loading, it defines all the needed functions and classes
needed when users load the dataset.

### `generate_train_test_split.py`
This file is designed to work with my local OS to generate train and test splits for the dataset. It will split the
dataset into a 70:30 train-test split ratio. The audio files will be directly compiled into a `.tar` file. While the
transcriptions will be automatically compiled into a `.tsv` file.

For more info about how the dataset in structured, please visit VerbaLex Voice dataset card [here](https://huggingface.co/datasets/RitchieP/VerbaLex_voice).
