#!/usr/bin/python3
# Author: Kraen Hansen (www.creen.dk)
# Date: February 2011
import sys
import os
import urllib.parse as urlparse

if __name__ == '__main__':
	command = ""
	if len(sys.argv) == 2 and sys.argv[1] != "":
		argument = urlparse.urlparse(sys.argv[1])
		if(argument.scheme == 'mailto'):
			mailoptionsSplitted = argument.path.replace("?","&").split("&")
			options = {}
			if(len(mailoptionsSplitted) >= 1):
				options['to'] = mailoptionsSplitted[0]
			for option in mailoptionsSplitted:
				temp = option.split("=")
				if(len(temp) == 2):
					options[temp[0]] = temp[1]
			#print options
			command += "firefox-auto-profile 'https://mail.google.com/mail?view=cm&tf=0"
			if 'to' in options.keys():
				command += "&to="+options['to']
			if 'cc' in options.keys():
				command += "&cc="+options['cc']
			if 'bcc' in options.keys():
				command += "&bcc="+options['bcc']
			if 'subject' in options.keys():
				command += "&su="+options['subject']
			if 'body' in options.keys():
				command += "&body="+options['body']
			command += "'";
		else:
			print("Unknown scheme:",argument.scheme)
	else:
		command = "firefox-auto-profile 'https://mail.google.com/mail/#inbox'"
	os.system(command);
