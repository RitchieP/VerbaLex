# VerbaLex
Automatic Speech Recognition system for patients with speech disorders. This project is a university final year 
project. Inspired by Google's [Project Euphonia](https://sites.research.google/euphonia/about/), this project aims 
to replicate similar machine learning model for more people. With hopes to addon features to not only recognize 
voices for people with speech disorders, but also for people who have a very heavily accented language. 

## Setup
### Environment
The environment for this project uses [`Anaconda`](https://www.anaconda.com/). To set up the 
anaconda environment, follow the guide on PyCharm's documentation about [configuring a conda 
environment](https://www.jetbrains.com/help/pycharm/conda-support-creating-conda-virtual-environment.html).

### Packages
Packages that is currently needed are:
1.  `transformers`
2.  `datasets`
3.  `tensorflow`

### Development
This project is currently developed by using a pre-trained model from HuggingFace. After having a pre-trained model, 
the project will fine tune the model based on speech disorder dataset or heavily accented language.