# AD-Scripting, Astrid Bos & David Scholte-Albers
# 09 January 2014
# Exercise 5

#function downloads the data and unzips it in the wd/data folder

download_data <- function(URL){
        download.file(url=URL, destfile='data/URL.zip', method='auto')
        unzip('data/URL.zip', exdir="data")
}