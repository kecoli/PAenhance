<<<<<<< HEAD
inslib <-
function(x){
	x <-as.character(substitute(x))
	if(!x %in% rownames(installed.packages())) 
	{install.packages(x,repos="http://cran.stat.ucla.edu")}
	eval(parse(text=paste("library(",x,")",sep="")))}
=======
inslib <-
function(x){
	x <-as.character(substitute(x))
	if(!x %in% rownames(installed.packages())) 
	{install.packages(x,repos="http://cran.stat.ucla.edu")}
	eval(parse(text=paste("library(",x,")",sep="")))}
>>>>>>> a5e52e3aa047a1e03a04d2b57852d2c075519093
