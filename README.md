# UTER
This repository contains example code and data files for the MEFM South Australian library, and first steps towards applying it for Uruguay's UTE data.

I suggest strongly reading and going through the  [MEFM code first](https://github.com/robjhyndman/MEFM-package "The R package MEFM includes a set of tools for implementing the Monash Electricity Forecasting Model based on the paper by Hyndman and Fan (2010).").

## Files

- `hellomefm.R`: Example code that demonstrates the usage of the MEFM South Australian library.
- `dataloader.r`: Example code that loads temperature and demand data.
- `quantvsrank.R`: Visualization test for the probability of exceedance (PoE).
- `testPoE.R`: Another visualization test for the PoE.
- `mvd.R`: Code that processes Montevideo data with the MEFM South Australian library.

## Data files

- `dataset.csv`: A large dataset containing climate data for a territorial grid in the whole country for the year 2021. Cannot be uploaded to GitHub due to size constraints. You can download it using the `download_data.sh` script located in the root of this repository.
- `dataset_2000a2010_puntos_167_y_188.csv`: Climate data only for Montevideo, years 2000 to 2010. You can download it using the `download_data.sh` script located in the root of this repository.
- `dataset_2011a2021_puntos_167_y_188.csv`: Climate data only for Montevideo, years 2011 to 2021. You can download it using the `download_data.sh` script located in the root of this repository.
- `PDA/Ricaldoni_v1.sqlite`: SQL dataset containing demand data. Cannot be uploaded to GitHub due to size constraints. You can download it using the `download_data.sh` script located in the root of this repository.

## How to use (Linux)

Clone the repository:
``` console
git clone https://github.com/yourusername/repo-name.git
```
To download the data files, run the `download_data.sh` script:
``` console
cd repo-name
./download_data.sh
```
Run the example code files by executing the following command:
``` console
Rscript filename.R
```
Replace `filename.R` with the name of the file you want to run.
