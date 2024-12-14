# Common CLI to run Prolog code snippets using different engines

Portable interface to multitude of Prolog implementations. The main purpose is
to help with spotting differences and facilitate comparison in behavior for
test snippets of code during development for Prolog engine maintainers.

This program doesn't provide engines themselves, you need to install them
separately. The easiest way is to get this package from [AUR][AUR] with all
optional dependencies.

Otherwise you can try a [containerized][Docker] variant.

🚧 This project was tested only on Arch Linux, but there is nothing here to fail,
it just re-arranges arguments and calls an actual Prolog executable. That means
that if you have installed Prolog system-wide it should just work for you too.

[AUR]: https://aur.archlinux.org/packages/prologs
[Docker]: https://github.com/hurufu/prolog-docker

## Usage examples

Run `foo,bar` from `file.pl` with all available prologs (both variants do the same):

    prologs -g foo -g bar file.pl
    prologs -p all -g foo,bar 'my file with spaces.pl'

Read its help `prologs -h` for more options.

The program is implemented in Make, that means that it supports parallel
execution out-of-the box. This will run `main` from `my_prject.pl` with Scryer
and Trealla Prologs simultaneously:

    prologs -p scryer -p trealla -j2 -O -g main -- my_project.pl

You can use `remake(1)` to compare execution time of different implementations:

    env MAKE=remake prologs -g run --profile bench.pl

Or alternatively in the future you would be able to use [biomake][biomake] to
run your code on distributed cluster using queueing engine:

    env MAKE=biomake prologs -g run bench.pl -j -Qpbs

[biomake]: https://github.com/evoldoers/biomake

## Currently working

B, Bin, C#Prolog, Ciao, DGKS, Doge (JavaScript, Python, Java), ECLiPSe, GNU Prolog, Poplog,
Projog, Scryer, SICStus[^1], SWI, Trealla, Tau, Tu, XSB, Yap.

## Notes on some less known Prologs

  * [DGKS Prolog][e] – Looks like a someone's toy project from late 90', no CLI
    interface without writing custom Java code, can't handle operators correctly.

## Tried and wouldn't be supported

  * [JLog][a] – only GUI. JScriptLog has stuck in unfinished state from 2007,
    it runs, but it seems to support only hardcoded KB – some development is
    required.
  * [LPA-Prolog][b] – commercial license is needed.
  * [Brain Aid Prolog][c] – can't find sources.
  * [Strawberry Prolog][d] – full IDE no easy way to integrate
    into CLI.
  * Turbo Prolog – can't find sources and it seems to be a lot of pain anyways.
    Links:
      * [Turbo Prolog Goodies][f]
  * [Quintus Prolog][g] – sources are paywalled, no real reason to use because
    it's successor SICStus is available.
  * [Minerva Prolog][h] – source code is unobtainium now.
  * [Amzi! Prolog][j] – looks like a complete IDE, hard to compile.
  * [Jinni Prolog][k] – code is freely availvable, but I don't have stamina to
    fix all compilation issues.
  * [IF/Prolog][l] – there are some very old sources, it might work or might not.
  * [BIM Prolog][m] – A lot of information, but no sources nor executables.
  * [Jekejeke Prolog][n] – I have found archived page, but .jar file wasn't
    archived and I don't like downloading it from random sites on internet.

## Still needs research

  * [Ichiban Prolog][o]
  * Other systems: https://www.softwarepreservation.org/projects/prolog/
  * https://gitlab.com/gule-log/guile-log
  * https://github.com/DouglasRMiles/QuProlog
  * SmallTalk Prolog
  * https://github.com/leonweber/spyrolog
  * https://github.com/ptarau/iProlog
  * https://github.com/GunterMueller/UNSW_Prolog_and_iProlog
    https://www.cse.unsw.edu.au/~claude/research/software/prolog.html
  * http://www.projog.org/
  * https://github.com/JalogTeam/Jalog
  * ExperProlog
  * https://github.com/teyjus/teyjus
  * https://github.com/ptarau/StylaProlog
  * LinProlog https://github.com/ptarau/AgenticProlog (??)

[^1]: You need to have a legally obtained copy installed in /opt/SICStus

[a]: https://jlogic.sourceforge.net/ "JLog and JScriptLog sources"
[b]: https://www.lpa.co.uk/ind_pro.htm
[c]: http://www.fraber.de/bap/index.html
[d]: https://dobrev.com/
[e]: https://web.archive.org/web/20090724160647/http://geocities.com/SiliconValley/Campus/7816/
[f]: https://web.archive.org/web/20031203213809/http://perso.wanadoo.fr/colin.barker/tpro/tpro.htm
[g]: https://quintus.sics.se/
[h]: https://web.archive.org/web/20121105020447/http://www.ifcomputer.co.jp/MINERVA/Download/home_en.html
[j]: http://www.amzi.com/AmziOpenSource/
[k]: https://github.com/heathmanb/JinniProlog
[l]: https://web.archive.org/web/20170717032834/http://www.ifcomputer.de/Products/Prolog/Download/home_de.html
[m]: https://people.cs.kuleuven.be/~Maurice.Bruynooghe/Prolog/Prolog.html
[n]: https://web.archive.org/web/20200223033605/http://www.jekejeke.ch/idatab/doclet/prod/en/docs/05_run/05_down.jsp
[o]: https://github.com/ichiban/prolog
