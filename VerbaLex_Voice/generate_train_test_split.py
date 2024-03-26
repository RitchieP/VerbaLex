# This file is used to generate the train and test split of files within
# the file system.

import os
import re
import shutil
import tarfile
from math import floor
from random import shuffle


def get_file_list_from_dir(data_dir):
    """Get a list of files within the directory"""
    all_files = os.listdir(os.path.abspath(data_dir))
    data_files = list(filter(lambda file: file.endswith('.wav'), all_files))
    return data_files


# Due to the audio and transcript files are in different folders, we need to split
# them into train and test splits while maintaining their correct mapping in both splits
# For example, if transcript 0001 is in test split, audio 0001 should also be in test split.
#
# Hence, instead of splitting the files itself, I will split the files based on their
# ID number. Because every transcript and audio file has an ID number.
# For example, arctic_a0001.txt is the transcript for arctic_a0001.wav.
#
# After splitting the ID numbers, we will then assign the files to their respective splits
# based on their ID numbers.
def shuffle_file_id(files):
    file_id_regex = re.compile(r'[a-z]\d\d\d\d')
    file_id = []

    for file in files:
        file_id.append(file_id_regex.search(file).group())

    shuffle(file_id)
    return file_id


def train_test_splits(file_ids, training_ratio):
    split=training_ratio
    split_index = floor(len(file_ids) * split)
    train = file_ids[:split_index]
    test = file_ids[split_index:]
    return train, test



if __name__ == "__main__":
    print("Running")
    audio_file_paths = {
        "ABA": "C:\\Users\\user\\OneDrive - Universiti Sains Malaysia\\Assignment\\FYP\\l2arctic_release_v5.0\\ABA\\ABA\\wav",
        "BWC": "C:\\Users\\user\\OneDrive - Universiti Sains Malaysia\\Assignment\\FYP\\l2arctic_release_v5.0\\BWC\\BWC\\wav"
    }
    speaker_accent_map = {
        "ABA": "ar",
        "BWC": "zh"
    }
    splits = ["train", "test"]

    try:
        for speaker, accent in speaker_accent_map.items():
            audio_files = get_file_list_from_dir(audio_file_paths[speaker])
            shuffled_file_id = shuffle_file_id(audio_files)
            train, test = train_test_splits(shuffled_file_id, 0.7)

            print(train)
            print("Number of samples in training: ", len(train))
            print(test)
            print("Number of samples in testing: ", len(test))
            tar_file = tarfile.open(
                f"C:\\Users\\user\\OneDrive - Universiti Sains Malaysia\\Assignment\\FYP\\data\\audio\\{accent}\\train\\{accent}_train.tar",
                "w"
            )
            for id in train:
                # Copy training audio into a tar file
                tar_file.add(
                    f"C:\\Users\\user\\OneDrive - Universiti Sains Malaysia\\Assignment\\FYP\\l2arctic_release_v5.0\\{speaker}\\{speaker}\\wav\\arctic_{id}.wav",
                    arcname=f"arctic_{id}.wav"
                )

                # Copy training transcript into a tsv file
                with open(f"C:\\Users\\user\\OneDrive - Universiti Sains Malaysia\\Assignment\\FYP\\data\\transcript\\{accent}\\train.tsv", 'a') as tsv_file:
                    with open(f"C:\\Users\\user\\OneDrive - Universiti Sains Malaysia\\Assignment\\FYP\\l2arctic_release_v5.0\\{speaker}\\{speaker}\\transcript\\arctic_{id}.txt") as txt_file:
                        tsv_file.write(txt_file.read() + "\n")
                tsv_file.close()
            tar_file.close()

            # Copy testing audio into tar file
            tar_file = tarfile.open(
                f"C:\\Users\\user\\OneDrive - Universiti Sains Malaysia\\Assignment\\FYP\\data\\audio\\{accent}\\test\\{accent}_test.tar",
                "w"
            )
            for id in test:
                tar_file.add(
                    f"C:\\Users\\user\\OneDrive - Universiti Sains Malaysia\\Assignment\\FYP\\l2arctic_release_v5.0\\{speaker}\\{speaker}\\wav\\arctic_{id}.wav",
                    arcname=f"arctic_{id}.wav"
                )

                # Copy testing transcript into tsv file
                with open(f"C:\\Users\\user\\OneDrive - Universiti Sains Malaysia\\Assignment\\FYP\\data\\transcript\\{accent}\\test.tsv", 'a') as tsv_file:
                    with open(f"C:\\Users\\user\\OneDrive - Universiti Sains Malaysia\\Assignment\\FYP\\l2arctic_release_v5.0\\{speaker}\\{speaker}\\transcript\\arctic_{id}.txt") as txt_file:
                        tsv_file.write(txt_file.read() + "\n")
                tsv_file.close()
            tar_file.close()

    except PermissionError:
        print("Permission denied")
