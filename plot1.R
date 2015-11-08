#Se define el url de donde se obtiene el archivo zip
url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#Preguntamos si existe el archivo 
if( file.exists("power_consumption.zip")) {
  print("El archivo existe por lo que procedemos a borrarlo")
  unlink("power_consumption.zip")
} 
print("Descargando el archivo")
download.file(url, destfile = "power_consumption.zip", method = "curl")
dateDownloaded <- date()
file <- unzip("power_consumption.zip")

print("Leemos el archivo")
power <- read.table(file, header = T, sep = ";")
#head(power)
power$Date <- as.Date(power$Date, format="%d/%m/%Y")