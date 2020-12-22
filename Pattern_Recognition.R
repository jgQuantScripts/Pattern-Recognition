#install.packages("devtools")
# require("devtools")
# install_github("prodipta/techchart")
require("techchart")
require("quantmod")
require("data.table")
# get Patterns

getPatterns = function(ticker)
{
  data <- getSymbols(ticker, from="2020-01-01",auto.assign = FALSE)
  
  tmp <- lapply(as.list(1:4), function(x){
    pat <- find.pattern(data, pattern = pattern.db("all")[[x]])
    if(!is.null(pat))
    {
      nom <- as.data.frame(pat$matches[[1]]$name)
      dur <- as.data.frame(pat$matches[[1]]$duration)
      stat <- as.data.frame(pat$matches[[1]]$type)
      dat <- as.data.frame(pat$matches[[1]]$data)
      datx <- as.data.frame(pat$matches[[1]]$date)
      all <- cbind(row.names(dat),dat,nom,dur,stat,ticker,datx)
      colnames(all) <- c("Date","Data","Pattern","Duration","Status","Ticker","DateMatched")
      all
    }})
  tmp <- tmp[lapply(tmp,length)>0]
  tmp <- rbindlist(tmp,use.names = TRUE)
  tmp
}


data <- getPatterns(ticker="DIA")
