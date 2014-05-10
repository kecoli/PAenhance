PAenhance
=========

##  NEWS
Updates: 05/03 
Fixed bugs from Semideviance metric. 

##  Description 
PerformanceAnalytics Enhancement 

table.Performance() aims to summerize return metrics ( risk, performance, statistics). It allows user to select metric sets and modify optional arguments (e.g., risk free rate) in the interactive (though a big limited) data edtior window from R-console. 


## INSTALL 
the latest development version:
```
install.packages("devtools")
devtools::install_github("devtools")
library(devtools)
install_github("kecoli/PAenhance")
library(PAenhance)
```
Get main help page for package
```
help(package = "PAenhance")
```
 Get description file
```
packageDescription("PAenhance") # Short description
library(help=PAenhance)
```

List functions
```
ls("package:PAenhance")
```
