%title: LUMI Software Stacks (demos)
%author: Kurt Lust
%date: 2022-04-28

-> # module spider <-

```
module spider
```

* Long list of all installed software with short description
    - Will also look into modules for “extensions” and show those  
      also, marked with an \“E\”

-------------------------------------------------

-> # module spider <-

* With the (suspected) name of a package

```
module spider gnuplot
```

* Shows all versions of gnuplot on the system
* Case-insensitive

```
module spider GNUplot
```

-------------------------------------------------

-> # module spider <-

* With the (suspected) name of a package

```
module spider cmake
```

* `CMake` turns out to be an extension but `module spider`
  still manages to tell which versions exist.

-------------------------------------------------

-> # module spider <-

* With the full module name of a package

```
module spider gnuplot/5.4.3-cpeGNU-21.12 
```

* Shows help information for the specific module, including 
  what should be done to make the module available
* But this does not completely work with the Cray PE modules

-------------------------------------------------

-> # module spider <-

* With the name and version of an extension

```
module spider CMake/3.22.2 
```

* Will tell you which module contains CMake and how to load
  it

```
module spider buildtools/21.12
```

-------------------------------------------------

-> # module keyword <-

* Currently not yet very useful due to a bug in Cray Lmod
* It searches in the module short description and help for 
  the keyword.

```
module keyword https
```

* We do try to put enough information in the modules to make
  this a suitable additional way to discover software that is
  already installed on the system

-------------------------------------------------

-> # sticky modules and module purge <-

* On some systems, you will be taught to avoid module purge
  (which unloads all modules)
* Sticky modules are modules that are not unloaded by 
  `module purge`, but reloaded.
    - They can be force-unloaded with `module –-force purge`
      and `module –-force unload`

```
module list
module purge
module list
module --force unload ModuleLabel/label
module list
```

* Used on LUMI for the software stacks and modules that set 
  the display style of the modules
    - But keep in mind that the modules are reloaded, which 
      implies that the target modules and partition module 
      will be switched (back) to those for the current node.

```
module load init-lumi
module list
```

-------------------------------------------------

-> # Changing the module list display <-

* You may have noticed that you don’t see directories in the 
  module view but descriptive texts
* This can be changed by loading a module
    * `ModuleLabel/label`: The default view
    * `ModuleLabel/PEhierarchy`: Descriptive texts, but the 
      PE hierarchy is unfolded
    * `ModuleLabel/system`: Module directories

```
module list
module avail
module load ModuleLabel/PEhiererachy
module avail
module load ModuleLabel/system
module avail
module load ModuleLabel/label
```

-------------------------------------------------

-> # Changing the module list display <-

* Turn colour on or off using ModuleColour/on or 
  ModuleColour/off

```
module avail
module load ModuleColour/off
module avail
module list
module load ModuleColour/on
```

-------------------------------------------------

-> # Changing the module list display <-

* Show some hidden modules with ModulePowerUser/LUMI
  This will also show undocumented/unsupported modules!

```
module load LUMI/21.12
module avail
module load ModulePowerUser
module avail
```

* Note that we see a lot more Cray PE modules with
  ModulePowerUser!


-------------------------------------------------

-> # Demo moment 2 <-


-------------------------------------------------

-> # Install GROMACS <-

* Search for a GROMACS build recipe

```
module load LUMI/21.12 partition/C EasyBuild-user
eb --search GROMACS
eb -S GROMACS
```

* Let’s take `GROMACS-2021.4-cpeCray-21.12-PLUMED-2.8.0-CPU.eb`

```
eb -r GROMACS-2021.4-cpeCray-21.12-PLUMED-2.8.0-CPU.eb -D
eb -r GROMACS-2021.4-cpeCray-21.12-PLUMED-2.8.0-CPU.eb
```

* Now the module should be available

```
module avail GROMACS
```
