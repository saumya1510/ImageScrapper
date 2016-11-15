#This program downloads images from a specifiec website. For reference, if run without making any changes
#it would download the first 200 issues of the JL8 webcomics.
#The code uses the following libraries.
library(rvest)
library(magrittr)

mainDir <- "\Pictures"
subDir <- "jl8"
dir.create(file.path(mainDir, subDir))
setwd(file.path(mainDir, subDir))
for (issue in 1:200){
  dest <- paste(subDir, issue, ".jpeg", sep="")
  if (!file.exists(dest)){
    pgurl <- paste("http://www.limbero.org/", subDir, "/", issue, sep = "")
    pghtml <- read_html(pgurl)
    nodes <- html_nodes(pghtml, xpath = "//*[@id=\"nav\"]/b[2]/img")	#identifies the img tag in the source code of the site.
    imgsrc <- html_attr(x = nodes[[length(nodes)]], "src")
    message(paste("Downloading ", dest, "...", sep = ""))
    download.file(imgsrc, destfile = dest, mode = "wb", quiet = T)
    #rstudio::viewer(url = dest)
  }else
  {
    message(paste(dest, " already exists"))
  }
}
