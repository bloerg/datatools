##function downsizes spectrum length by 0.5
#to this end every two wavelength bins are averaged
downsize_spectrum <- function(a_spectrum) {
    odd_elements <- a_spectrum[c(TRUE, FALSE)]
    even_elements <- a_spectrum[c(FALSE, TRUE)]
    n<-max(length(odd_elements), length(even_elements))
    length(odd_elements)<-n
    length(even_elements)<-n
    return(rowMeans(cbind(odd_elements, even_elements), na.rm=TRUE))
}

##function normalizes a spectrum, i.e.
#it divides every wavelength bin value by
#the maximum absolute value in a spectrum
normalize_spectrum <- function(a_spectrum) {
    return(a_spectrum/max(abs(a_spectrum)))
}



##Example implementation

spectrum_data<-read.csv('./example_spectrum.csv',header=T)
continuum_subtracted_spectrum<-spectrum_data$continuum_subtracted_spectrum
continuum_subtracted_spectrum_divided_by_two<-downsize_spectrum(continuum_subtracted_spectrum)


#plot result to example_spectrum.pdf
pdf("example_spectrum.pdf", height=12, width=6)
par(mfrow=c(2, 1), xpd=NA)

plot(data.frame(c(1:length(continuum_subtracted_spectrum)),normalize_spectrum(continuum_subtracted_spectrum)),type="n", xlab="wavelength bin", ylab="", main="Continuum subtracted spectrum")
lines(data.frame(c(1:length(continuum_subtracted_spectrum)),normalize_spectrum(continuum_subtracted_spectrum)))

plot(data.frame(c(1:length(continuum_subtracted_spectrum_divided_by_two)),normalize_spectrum(continuum_subtracted_spectrum_divided_by_two)),type="n", xlab="wavelength bin", ylab="", main="Continuum subtracted spectrum, every two bins averaged")
lines(data.frame(c(1:length(continuum_subtracted_spectrum_divided_by_two)),normalize_spectrum(continuum_subtracted_spectrum_divided_by_two)))

dev.off()
