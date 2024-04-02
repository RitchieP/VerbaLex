import csv
import os

import datasets
from tqdm import tqdm

from .accents import ACCENTS
from .release_stats import STATS

_HOMEPAGE = "https://huggingface.co/datasets/RitchieP/VerbaLex_voice"

_LICENSE = "https://choosealicense.com/licenses/apache-2.0/"

_BASE_URL = "https://huggingface.co/datasets/RitchieP/VerbaLex_voice/resolve/main/"

_AUDIO_URL = _BASE_URL + "audio/{accent}/{split}/{accent}_{split}.tar"

_TRANSCRIPT_URL = _BASE_URL + "transcript/{accent}/{split}.tsv"

_CITATION = """\
"""


class VerbaLexVoiceConfig(datasets.BuilderConfig):
    def __init__(self, name, version, **kwargs):
        self.accent = kwargs.pop("accent", None)
        self.num_speakers = kwargs.pop("num_speakers", None)
        self.num_files = kwargs.pop("num_files", None)
        description = (
            f"VerbaLex Voice english speech-to-text dataset in {self.accent} accent."
        )

        super(VerbaLexVoiceConfig, self).__init__(
            name=name,
            version=datasets.Version(version),
            description=description,
            **kwargs,
        )


class VerbaLexVoiceDataset(datasets.GeneratorBasedBuilder):
    """
    VerbaLex is a dataset containing different English accents from non-native English speakers.
    This dataset is created directly from the L2-Arctic dataset.
    """
    BUILDER_CONFIGS = [
        VerbaLexVoiceConfig(
            name=accent,
            version=STATS["version"],
            accent=ACCENTS[accent],
            num_speakers=accent_stats["numOfSpeaker"],
            num_files=accent_stats["numOfWavFiles"]
        )
        for accent, accent_stats in STATS["accents"].items()
    ]

    DEFAULT_CONFIG_NAME = "ar"

    def _info(self):
        return datasets.DatasetInfo(
            description=(
                "VerbaLex Voice is a speech dataset focusing on accented English speech."
                "It specifically targets speeches from speakers that is a non-native English speaker."
            ),
            features=datasets.Features(
                {
                    "path": datasets.Value("string"),
                    "accent": datasets.Value("string"),
                    "sentence": datasets.Value("string"),
                    "audio": datasets.Audio(sampling_rate=44_100)
                }
            ),
            supervised_keys=None,
            homepage=_HOMEPAGE,
            license=_LICENSE,
            citation=_CITATION
        )

    def _split_generators(self, dl_manager):
        """Returns SplitGenerators"""
        accent = self.config.name

        splits = ("train", "test")
        audio_urls = {}
        for split in splits:
            audio_urls[split] = _AUDIO_URL.format(accent=accent, split=split)
        archive_paths = dl_manager.download(audio_urls)
        local_extracted_archive_paths = dl_manager.extract(archive_paths) if not dl_manager.is_streaming else {}

        meta_urls = {split: _TRANSCRIPT_URL.format(accent=accent, split=split) for split in splits}
        meta_paths = dl_manager.download_and_extract(meta_urls)

        split_names = {
            "train": datasets.Split.TRAIN,
            "test": datasets.Split.TEST
        }
        split_generators = []
        for split in splits:
            split_generators.append(
                datasets.SplitGenerator(
                    name=split_names.get(split, split),
                    gen_kwargs={
                        "local_extracted_archive_paths": local_extracted_archive_paths.get(split),
                        "archives": [dl_manager.iter_archive(path) for path in archive_paths.get(split)],
                        "meta_path": meta_paths[split]
                    }
                )
            )

        return split_generators

    def _generate_examples(self, local_extracted_archive_paths, archives, meta_path):
        data_fields = list(self._info().features.keys())
        metadata = {}
        with open(meta_path, encoding="UTF-8") as f:
            reader = csv.DictReader(f, delimiter="\t", quoting=csv.QUOTE_NONE)
            for row in tqdm(reader, desc="Reading metadata..."):
                if not row["path"].endswith(".wav"):
                    row["path"] += ".wav"
                for field in data_fields:
                    if field not in row:
                        row[field] = ""
                metadata[row["path"]] = row

        for i, audio_archive in enumerate(archives):
            for path, file in audio_archive:
                _, filename = os.path.split(path)
                if filename in metadata:
                    result = dict(metadata[filename])
                    path = os.path.join(local_extracted_archive_paths[i],
                                        path) if local_extracted_archive_paths else path
                    result["audio"] = {"path": path, "bytes": file.read()}
                    result["path"] = path
                    yield path, result
