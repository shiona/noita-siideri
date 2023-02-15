# Mod for Noita that allows playing a list of seeds in order

Created to help racing / competing

## Installation

Either
 - git clone this repo to `Noita/mods` directory, or
 - download the latest release, unzip it to `Noita/mods` **and** make sure the mod
   directory name is `siideri` without any version numbers or anything like that.

Unfortunately how Noita mods work, it seems this mod would not work if distributed
via steam workshop. Or so I am told.

## To use:

Create/modify the file `mods/siideri/files/seed_list.txt` to contain the list of
seeds you wish to play. Should be only numbers separated by commas.

In mod settings click _Load_ to load the `seed_list.txt`.
_Seed\_index_ is the index which seed will be used next. 1 meaning the first
number in the list, 2 the second and so on.

The checksum is there to help make sure each racer has successfully loaded
the same list.

Thanks to:
 - Evaisa for seed\_changer mod, which was used as the base for this one
 - dextercd, Ephemeris and Horscht for helping me understand Noita modding
 - Minni for the great name for the mod
