#!/usr/bin/python
import pyfits
import sys
import os

args=sys.argv

if (len(args) == 2):
    fits_file_name=args[1]
    #print args[1]
    if os.path.isfile(fits_file_name):
        fits_file = pyfits.open(fits_file_name)
        ##see http://classic.sdss.org/dr7/dm/flatFiles/spSpec.html#spec for data fields
        spectrum=fits_file[0].data[0]
        continnuum_subtracted_spectrum=fits_file[0].data[1]
        error=fits_file[0].data[2]
        sys.stdout.write('spectrum,continuum_subtracted_spectrum,error' + '\n')
        for i in range (0,len(spectrum)):
            output_string=str(spectrum[i]) + "," + str(continnuum_subtracted_spectrum[i]) + "," + str(error[i]) + '\n'
            sys.stdout.write(output_string)
