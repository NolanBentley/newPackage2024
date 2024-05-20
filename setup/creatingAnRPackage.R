#Variables
packageName <- "newPackage2024"
wd <- "~/GitHub"

#Setup location
fn <- rstudioapi::getSourceEditorContext()$path
setwd(wd)

#Check packages
if(!"devtools"%in%installed.packages()){install.packages("devtools")}
if(!"roxygen2"%in%installed.packages()){install.packages("roxygen2")}

#Create package
devtools::create(packageName)

#Create dir for storing R
pckDir <- file.path(packageName,"R")
dir.create(pckDir,showWarnings = F)

#Helper code for saving functions
exportFunction <- function(funDir, funName, funObj){
    funFile <- file.path(funDir,paste0(funName,".R"))
    exportedFunction <- deparse(funObj,width.cutoff = 500)
    exportedFunction[1]<-paste0(funName," <- ", exportedFunction[1])
    write(exportedFunction,funFile)
}
exportFunctionSet <- function(funDir, funNames, funsCatted,scriptFileName){
    funFile <- file.path(funDir,paste0(gsub("\\.R$","",scriptFileName),".R"))
    exportedFunctionList <- lapply(funsCatted,deparse,width.cutoff = 500)
    addNameFun <- function(x,y,i){
        x[1]<-paste0(y," <- ", x[1])
        x <- c(paste0("#### ",i," ####"),x,"","")
        return(x)
    }
    exportedFunctionList2 <- mapply(addNameFun,exportedFunctionList,funNames,format(1:length(funNames)))
    write(unlist(exportedFunctionList2),funFile)
}

#Write functions
exportFunction(pckDir,"exportFunction",exportFunction)
exportFunctionSet(
    funDir = pckDir,
    funNames   = c("exportFunction","exportFunctionSet"),
    funsCatted = c(exportFunction,exportFunctionSet),
    scriptFileName = "exportFunctionSet"
)

#Add documentation
setwd(packageName)
dir.create("setup",showWarnings = F)
file.copy(fn,"setup",overwrite = T)
devtools::document()






