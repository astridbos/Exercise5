download_data <- function(URL){
        download.file(url=URL, destfile='data/URL.zip', method='auto')
        unzip('data/URL.zip', exdir="data")
}