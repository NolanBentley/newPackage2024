exportFunction <- function (funDir, funName, funObj) 
{
    funFile <- file.path(funDir, paste0(funName, ".R"))
    exportedFunction <- deparse(funObj, width.cutoff = 500)
    exportedFunction[1] <- paste0(funName, " <- ", exportedFunction[1])
    write(exportedFunction, funFile)
}
