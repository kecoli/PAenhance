SharpeRatio <-
function (R, Rf = 0, p = 0.95, method = c("StdDev", "VaR", "ES"), 
		weights = NULL, annualize = FALSE, ...) 
{
	R = checkData(R)
	
	method <- match.arg(method)
	
	if (!is.null(dim(Rf))) 
		Rf = checkData(Rf)
	if (annualize) {
		freq = periodicity(R)
		switch(freq$scale, minute = {
					stop("Data periodicity too high")
				}, hourly = {
					stop("Data periodicity too high")
				}, daily = {
					scale = 252
				}, weekly = {
					scale = 52
				}, monthly = {
					scale = 12
				}, quarterly = {
					scale = 4
				}, yearly = {
					scale = 1
				})
	}
	else {
		scale = 1
	}
	srm <- function(R, ..., Rf, p, FUNC) {
		FUNCT <- match.fun(FUNC)
		xR = Return.excess(R, Rf)
		SRM = mean(xR, na.rm = TRUE)/FUNCT(R = R, p = p, ... = ..., 
				invert = FALSE)
		SRM
	}
	sra <- function(R, ..., Rf, p, FUNC) {
		if (FUNC == "StdDev") 
			FUNC = "StdDev.annualized"
		FUNCT <- match.fun(FUNC)
		xR = Return.excess(R, Rf)
		SRA = Return.annualized(xR)/FUNCT(R = R, p = p, ... = ..., 
				invert = FALSE)
		SRA
	}
	i = 1
	if (is.null(weights)) {
		result = matrix(nrow = length(method), ncol = ncol(R))
		colnames(result) = colnames(R)
	}
	else {
		result = matrix(nrow = length(method))
	}
	tmprownames = vector()
	
	for (FUNCT in method) {
		if (is.null(weights)) {
			if (annualize) 
				result[i, ] = sapply(R, FUN = sra, Rf = Rf, p = p, 
						FUNC = FUNCT, ...)
			else result[i, ] = sapply(R, FUN = srm, Rf = Rf, 
						p = p, FUNC = FUNCT, ...)
		}
		else {
			result[i, ] = mean(R %*% weights, na.rm = TRUE)/match.fun(FUNCT)(R, 
					Rf = Rf, p = p, weights = weights, portfolio_method = "single", 
					... = ...)
		}
		tmprownames = c(tmprownames, paste(if (annualize) "Annualized ", 
						FUNCT, " Sharpe", " (Rf=", round(scale * mean(Rf) * 
										100, 1), "%, p=", round(p * 100, 1), "%):", sep = ""))
		i = i + 1
	}
	rownames(result) = tmprownames
	return(result)
}
