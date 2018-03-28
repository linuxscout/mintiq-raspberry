# Introduction

This project aims to integrate arabic text to speach on eSpeak, and describe how to run it together.

The Objectif is to install a screen reader to allow to read screen in arabic.

## What we need?

As ingrédiants we need:

1. eSpeak with Arabic support
2. Mbrola system and voices
3. Screen Reader
4. Speech dispatcher
5. Arabic diacritizer for text.

We need to run a featured eSpeak TTS with Arabic support, an additional features and voices with Mbrola TTS system to get an best arabic voice. Then we Need also a diacritizer for diacritize texts \( Tashkeel\) تشكيل, by using an open source diactrictizer name [Mishkal](http://tahadz.com/mishkal). We need Also a screen reader as[ Orca](https://help.gnome.org/users/orca/stable/) and a[ speech dispatcher](https://devel.freebsoft.org/doc/speechd/speech-dispatcher.html) to configure TTS systems as middleware for voices applications.

Our aim is to get a good arabic voice with a correct as possible by diactrizing text.

## Installation

### Espeak with arabic support

[eSpeakNG](https://github.com/rhdunn/espeak) is a compact, open source, software speech synthesizer for Linux, Windows, and other platforms. It uses a formant synthesis method, providing many languages \(including arabic since version 1.49.2\) in a small size. Much of the programming for eSpeakNG's language support is done using rule files with feedback from native speakers.

To install espeak you can use the following instructions in espeakNG documentaion

For older version of eSpeak you can dowload a featured binary version from: [ar-espeak](http://arabic-tools.github.io/ar-espeak/).

For older version, you can only dowload the zipped file for espeak-data compiled to support arabic, from  [ar-espeak](#), choose the file which correspand to your version.

For example, I use the 1.48.03 version on my Linux machine, I download the[ espeak-data zipped file](https://sourceforge.net/projects/arabic-espeak/files/espeak-data1.48.03.zip/download)

```
$wget https://sourceforge.net/projects/arabic-espeak/files/espeak-data1.48.03.zip/download
$ unzip espeak-data1.48.03.zip
$ cp -R espeak-data ~
```

The first step is to download the zipped file, unzip it, and cy the espeak-data to you home user directory, because espeak will test if espeak-data directory is placed in your home, it will used it.

Now you can test espeak by the following command

```sh
$espeak -v en "Hello world"
```

if espeak work,  you can  list all available voices and language by you test it for arabic language by:

```
$espeak --voices
```

If arabic in listed you can  you test it for arabic language by:

```
$espeak -v ar "السلام عليكم"
```

The espeak program will use espeak-data directory placed in your home user directory or the default system directorty   like /usr/share/doc/espeak-data.

The espeak-data directory contains compiled files and phoneme-data which will be used by espeak . Youmust be care about espeak version.

We recommand to use new versions which support directly arabic language.

## Mbrola

> You can skip this part, If you don't need to use Mbrola, or you can't

[MBROLA](http://tcts.fpms.ac.be/synthesis/mbrola.html) is an algorithm for speech synthesis, and software which is distributed at no financial cost but in binary form limited to non-commerical use, and a worldwide collaborative project. The MBROLA project web page provides diphone databases for a large number of spoken languages.

The arabic voice developped by Mbrola is better than native voice given by espeak.

First, you must install Mbrola, you can use you package manager or

**For Debian/ubuntu like distributions :**

```
sudo apt-get install mbrola
```

Archlinux:

```
$ sudo pacman -S mbrola
```

For Archlinux run on Raspberry, use

```
cd /tmp
git clone git@github.com:saez0pub/mbrola-archlinux-rasberrypi.git
cd mbrola-archlinux-rasberrypi
makepkg -s
sudo pacman -U ./mbrola-3.02b-4-armv6h.pkg.tar.xz
```

Now, You can test Mbrola by

```
$ mbrola
```

To run Mbrola, we need to download voices:

* English:

* * [us1: American English Female \(6.8Mb\)](http://www.tcts.fpms.ac.be/synthesis/mbrola/dba/us1/us1-980512.zip)  [Babel Technology](mailto:secr%40babeltech.be)
  * [us2: American English Male \(6.3Mb\)](http://www.tcts.fpms.ac.be/synthesis/mbrola/dba/us2/us2-980812.zip) [Babel Technology](mailto:secr%40babeltech.be)
  * [us3: American English Male \(6.1Mb\)](http://www.tcts.fpms.ac.be/synthesis/mbrola/dba/us3/us3-990208.zip) [Mike Macon](mailto:macon%40cse.ogi.edu)
* Arabic:

  * [ar1: Arabic Male \(5.1Mb\)](http://www.tcts.fpms.ac.be/synthesis/mbrola/dba/ar1/ar1-981103.zip) [Faculte Polytech. De Mons](mailto:mbrola%40tcts.fpms.ac.be)
  * [ar2: Arabic Male \(5.6Mb\)](http://www.tcts.fpms.ac.be/synthesis/mbrola/dba/ar2/ar2-001015.zip) [Abdel Muez Abukhalaf](mailto:amuez%40sedco-online.com)

  After download, unzip files, and copy the files ar1, ar2 into the specific directory

Debian/Ubuntu/ Archlinux

```
$ mkdir -p /usr/share/mbrola/voices
$ cp ar1 /usr/share/mbrola/voices/
$ cp ar2 /usr/share/mbrola/voices/
```

Now, You can test it with espeak

* ```
  $ espeak -v mb-en1 "Hello World"
  $ espeak -v mb-ar1 "السلام عليكم"
  ```

## Configure a Screen Reader

We can use Orca Screen reader,

Install Orca

Configure Orca

You can test orca on desktop, orca use speech-dispatcher.

run on console within desktop

```
$ orca -s
```

Get the following Screen

![](/assets/Screen Reader Preferences_002.png)

From the dialog window, go to voice tab, then specify which person voice to use, Here we select Arabic default voice.

To test it, you can rerun orca with new configuration by the command line

```
$orca -r
```

## Diacritizer

In order to improve arabic Text to Speech, we propose to use a diacritizer. Arabic text comes usaully without short vowels, for this reason, we need to add short vowels to it, this process is called diacritizion.

The Idea is to use diacritizer as a wraper, it take text, diacritize it, before passing by the TTS system.

We will use [Mishkal: open source Arabic text diacritizer](http://tahadz.com/mishkal); Mishkal is written by Python langaue, it's open source. it has console, desktop and web interfaces.

We will use i as console command.

To install it, download it from [http://mishkal.sourceforge.net](http://mishkal.sourceforge.net), in many packaging versions for your distribution, or get it from github.

```
$ git clone https://github.com/linuxscout/mishkal.git
```

copy the files into a directory, I choose here to put it in my home user directory

```
/home/me/mishkal-master/
```

You can test it by python 2.7

```
$python2 mishkal-master/bin/mishkal-console.py 
(C) CopyLeft 2012, Taha Zerrouki
Usage: mishkal-console -f filename [OPTIONS]
       mishkal-console 'السلام عليكم' [OPTIONS]

        [-f | --file = filename]input file to mishkal-console
        [-h | --help]     outputs this usage message
        [-v | --version]  program version
        [-p | --progress]  display progress status

        * Tashkeel Actions
        -------------------
        [-r | --reduced]  Reduced Tashkeel.
        [-s | --strip]    Strip tashkeel (remove harakat).
        [-c | --compare]  compare the vocalized text with the program output

        * Tashkeel Options
        ------------------
        [-l | --limit]    vocalize only a limited number of line
        [-x | --syntax]   disable syntaxic analysis
        [-m | --semantic] disable semantic analysis
        [-i | --ignore]   ignore the last Mark on output words.
        [-t | --stat]     disable statistic tashkeel

This program is licensed under the GPL License
```

To test it with text

```
$python2 mishkal-master/bin/mishkal-console.py  "السلام عليكم"
 السِّلَام عَلَيْكُمْ
```

You can also use Mishkal as graphical interface

```
$python2 mishkal-master/interfaces/gui/mishkal-gui.py
```

![](/assets/mishkal-gui.png)

Also, You can run it as web server, this option allow you to run it like the online website

```
$python2 mishkal-master/interfaces/web/mishkal-webserver.py
serving on 0.0.0.0:8080 view at http://127.0.0.1:8080
```

Then, run your browser on URL :  [http://127.0.0.1:8080](http://127.0.0.1:8080)

![](/assets/mishkal-web4.png)

The webserver provide an API, to be used for developement of other apps.

## Integration

Now, we can proceed to integrate Diacritizer with TTS.

First, we test espeak with Mishkal by using pipe

```
$python2 mishkal-master/bin/mishkal-console.py  "السلام عليكم" | espeak -v ar
```

Second, we test it with Mbrola voices

```
$python2 mishkal-master/bin/mishkal-console.py  "السلام عليكم" | espeak -v mb-ar1
```

### Configure Speech-dispatcher

Install Speech Dispatcher

Install the packages for Speech Dispatcher from your distribution or download the source tarball \(or git\) from [http://www.freebsoft.org/speechd](http://www.freebsoft.org/speechd) and follow the instructions in the file `INSTALL` in the source tree.

Configure Speech Dispatcher

You can skip this step in most cases. If you however want to setup your own configuration of the Dispatchers default values, the easiest way to do so is through the `spd-conf` configuration script. It will guide you through the basic configuration. It will also subsequently perform some diagnostics tests and offer some limited help with troubleshooting. Just execut

```
$spd-conf
```

Test Speech Dispatcher

The simplest way to test Speech Dispatcher is through `spd-conf -d` or through the `spd-say` tool.

Example:

```
spd-conf -d
spd-say "Hello!"
spd-say -l cs -r 90 "Ahoj"
```

#### How to use eSpeak with MBROLA

Configuration will be generated in .config/speech-dispatcher  in the home user directory.

Check the ‘modules/espeak-mbrola-generic.conf’ configuration files for the `AddVoice` lines. If a line for any of the voices you have installed \(and it is supported by your version of eSpeak, e.g. `ls /usr/share/espeak-data/voices/mb/mb-*`\) is not contained here, please add it.

Check if `GenericExecuteString` contains the correct name of your mbrola binary and correct path to its voice database.

Uncomment the `AddModule` line for `espeak-mbrola-generic` in ‘speechd.conf’ in your configuration for Speech Dispatcher.

Restart speech-dispatcher and in your client, select `espeak-mbrola-generic` as your output module, or test it with the following command

```
spd-say -o espeak-mbrola-generic -l en Testing
```

#### 

Edit the file

```
nano .config/speech-dispatcher/modules/espeak-mbrola-generic.conf
```

Adding Arabic language,  go to GenericLanguage     section, add the following line at the end of list

```
GenericLanguage          "ar" "ar" "utf-8"
```

Go to AddVoice section and add this lines

```
AddVoice        "ar"    "MALE1"        "ar1"
AddVoice        "ar"    "FEMALE1"    "ar1"
AddVoice        "ar"    "MALE1"         "ar2"
AddVoice        "ar"    "FEMALE1"       "ar2"
```

Restart speech-dispatcher and in your client, select `espeak-mbrola-generic` as your output module, or test it with the following command

```
spd-say -o espeak-mbrola-generic -l en Testing
```

Now test it with Arabic

```
spd-say -o espeak-mbrola-generic -l ar "السلام عليكم"
```

#### How to add diacritizer to speech-dispatcher

Edit the file

```
nano .config/speech-dispatcher/modules/espeak-mbrola-generic.conf
```

Now,  The check GenericExecuteSynth section

```
GenericExecuteSynth \
"echo \'$DATA\' | espeak -v mb-$VOICE -s $RATE -p $PITCH $PUNCT -q --stdin --pho | mbrola -v $VOLUME -e /usr/share/mbrola/$VOICE/$VOICE - -.au | $PLAY_COMMAND"
```

Please check if your voices are in direcotirs like this  /usr/share/mbrola/$VOICE/$VOICE

for exmaple, english voice are placed in /usr/share/mbrola/en1/en1

It's not the case, please change the mbrola path in this command to be

```
/usr/share/mbrola/voices/$VOICE
```

Which means that all voices are in the same directory.

The command will be like this

```
GenericExecuteSynth \
"echo \'$DATA\' | espeak -v mb-$VOICE -s $RATE -p $PITCH $PUNCT -q --stdin --pho | mbrola -v $VOLUME -e /usr/share/mbrola/voices/$VOICE - -.au | $PLAY_COMMAND"
```

We can see, that the given data will be passed by echo command, then trsmitted to espeak then to mbrola and the player.

To use diacritizer as wrapper, We will replace echo command by our wrapper

Our wrapper command  is

```
python2 mishkal-master/bin/mishkal-console.py
```

The resulted configuration will be as

```
# adding mishkal
GenericExecuteSynth \
"python2 mishkal-master/bin/mishkal-console.py \'$DATA\'| espeak -v mb-$VOICE -s $RATE -p $PITCH $PUNCT -q --stdin --pho | mbrola -v $VOLUME -e /usr/share/mbrola/voices/$VOICE - -.au | $PLAY_COMMAND "# adding mishkal
```

Now, text pass by diacritizer before going to TTS.

Restart speech-dispatcher and in your client, select `espeak-mbrola-generic` as your output module, or test it with the following command

Now test it with Arabic

```
spd-say -o espeak-mbrola-generic -l ar "السلام عليكم"
```

In order to detect errors  you can run speech-dispatcher with debug level

```
speech-dispatcher -l 4
[Tue Dec  5 15:51:06 2017 : 74036] speechd: Speech Dispatcher 0.8.3 starting
[Tue Dec  5 15:51:06 2017 : 74143] speechd:    Trying to find /run/user/1000/speech-dispatcher
[Tue Dec  5 15:51:06 2017 : 74186] speechd:    Using directory: /run/user/1000/speech-dispatcher for pidfile and logging
[Tue Dec  5 15:51:06 2017 : 74251] speechd: Speech Dispatcher already running.

Speech Dispatcher already running.
```

Like this, you can find errors in /run/user/1000/speech-dispatcher directory .

If all thing work well, you can test now your screen reader.



## Supported by 

[![](/assets/bg-topo.jpg)](http://f123.org) 



