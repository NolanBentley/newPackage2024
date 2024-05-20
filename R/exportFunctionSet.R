#### 1 ####
exportFunction <- function (funDir, funName, funObj) 
{
    funFile <- file.path(funDir, paste0(funName, ".R"))
    exportedFunction <- deparse(funObj, width.cutoff = 500)
    exportedFunction[1] <- paste0(funName, " <- ", exportedFunction[1])
    write(exportedFunction, funFile)
}


#### 2 ####
exportFunctionSet <- function (funDir, funNames, funsCatted, scriptFileName) 
{
    funFile <- file.path(funDir, paste0(gsub("\\.R$", "", scriptFileName), ".R"))
    exportedFunctionList <- lapply(funsCatted, deparse, width.cutoff = 500)
    addNameFun <- function(x, y, i) {
        x[1] <- paste0(y, " <- ", x[1])
        x <- c(paste0("#### ", i, " ####"), x, "", "")
        return(x)
    }
    exportedFunctionList2 <- mapply(addNameFun, exportedFunctionList, funNames, format(1:length(funNames)))
    write(unlist(exportedFunctionList2), funFile)
}


