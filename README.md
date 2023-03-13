# UTER
This repository contains example code and data files for the MEFM South Australian library, and first steps towards applying it for Uruguay's UTE data.

## Files

- `hellomefm.R`: Example code that demonstrates the usage of the MEFM South Australian library.
- `dataloader.r`: Example code that loads temperature and demand data.
- `quantvsrank.R`: Visualization test for the probability of exceedance (PoE).
- `testPoE.R`: Another visualization test for the PoE.
- `mvd.R`: Code that processes Montevideo data with the MEFM South Australian library.

## Data files

- `dataset.csv`: A large dataset containing climate data. Cannot be uploaded to GitHub due to size constraints. You can download it using the `download_data.sh` script located in the root of this repository.
- `PDA/Ricaldoni_v1.sqlite`: SQL dataset containing demand data. Cannot be uploaded to GitHub due to size constraints. You can download it using the `download_data.sh` script located in the root of this repository.

## How to use

Clone the repository:
``` console
git clone https://github.com/yourusername/repo-name.git
```
To download the `dataset.csv` file, run the `download_data.sh` script:
``` console
cd repo-name
./download_data.sh
```
Run the example code files by executing the following command:
``` console
Rscript filename.R
```
Replace `filename.R` with the name of the file you want to run.
