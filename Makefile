# MakeFile
# Description of functionality like: Automate Raspberry Pi image builds
# Take a config file on the command line and pass its options to the various stages of the build process
#
# Copyright 2018, F123 Consulting, <information@f123.org>
# Copyright 2018, Taha Zerrouki, <taha.zerrouki@gmail>
#
# This is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free
# Software Foundation; either version 3, or (at your option) any later
# version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this package; see the file COPYING.  If not, write to the Free
# Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.
#


MBROLAVOICES :=packages/voices
ESPEAK-DATA := /home/f123/

# test it
mishkal:
	unzip mishkal-reduced.zip 
	echo "Install Mishkal arabic diacritizer "
	mkdir -p /opt/mishkal/
	chmod 777 -R /opt/mishkal
	cp -ur mishkal-reduced/* /opt/mishkal
	ln -f -s /opt/mishkal/bin/mishkal-console.py /usr/bin/mishkal
	chmod +x /usr/bin/mishkal
	echo "test mishkal"
	mishkal "السلام عليكم"
mishkal-espeak:
	echo "test eSpeak with Mishkal"
	mishkal "السلام عليكم" | espeak-ng -v ar -w test.wav
	echo "test Mrobla with Mishkal"
	mishkal "السلام عليكم" | espeak-ng -v mb-ar1  -w testm.wav
#Section 3
# Test speech-dispatcher
# Configure Orca
dispatcher:
	cp /etc/speech-dispatcher/modules/espeak-mbrola-generic.conf ~/.config/speech-dispatcher/modules/
	sed "s/#AddModule \"espeak-mbrola-generic\"/AddModule \"espeak-mbrola-generic\"/g" -i ~/.config/speech-dispatcher/speechd.conf
	sed "s/^\"echo /\"mishkal /g" -i ~/.config/speech-dispatcher/modules/espeak-mbrola-generic.conf
	sed "s/# AddVoice specifies which/GenericLanguage           \"ar\" \"ar\" \"utf-8\"\n# AddVoice specifies which/g" -i ~/.config/speech-dispatcher/modules/espeak-mbrola-generic.conf
	sed "s/# These parameters set/AddVoice        \"ar\"    \"MALE1\"         \"ar1\"\n\n# These parameters set/g" -i ~/.config/speech-dispatcher/modules/espeak-mbrola-generic.conf
	sed "s/# These parameters set/AddVoice        \"ar\"    \"FEMALE1\"         \"ar2\"\n\n# These parameters set/g" -i ~/.config/speech-dispatcher/modules/espeak-mbrola-generic.conf
espdisp:
	cp /etc/speech-dispatcher/modules/espeak-generic.conf ~/.config/speech-dispatcher/modules/
	sed "s/#AddModule \"espeak-generic\"/AddModule \"espeak-generic\"/g" -i ~/.config/speech-dispatcher/speechd.conf
	sed "s/^\"echo /\"mishkal /g" -i ~/.config/speech-dispatcher/modules/espeak-generic.conf
	sed "s/# AddVoice specifies which/GenericLanguage           \"ar\" \"ar\" \"utf-8\"\n# AddVoice specifies which/g" -i ~/.config/speech-dispatcher/modules/espeak-generic.conf
	sed "s/# These parameters set/AddVoice        \"ar\"    \"MALE1\"         \"ar1\"\n\n# These parameters set/g" -i ~/.config/speech-dispatcher/modules/espeak-generic.conf
	sed "s/# These parameters set/AddVoice        \"ar\"    \"FEMALE1\"         \"ar2\"\n\n# These parameters set/g" -i ~/.config/speech-dispatcher/modules/espeak-generic.conf
testdisp:
	rm  -f /run/user/1000/speech-dispatcher/log/espeak-generic.log 
	spd-say -o espeak-generic -l ar  "السلام عليكم"

testlog:
	tail /run/user/1000/speech-dispatcher/log/espeak-generic.log 
testespeak:
	spd-say -o espeak-mbrola-generic -l ar  "السلام عليكم"











