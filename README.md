# All the Prologs

🚧 Work-in-progress, beware. Was tested only on Arch Linux.

Portable interface to multitude of Prolog implementations. This program doesn't
provide engines themselves, you need to install them separately. The easiest
way is to get this package from [AUR](https://aur.archlinux.org/packages/prologs)
with all optional dependencies.

## Usage

Start SWI-Prolog top level interpreter:

    prologs -p swi

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

Or alternatively in the futurue you would be able to use
[biomake](https://github.com/evoldoers/biomake) to run your code on distributed
cluster using queueing engine:

    env MAKE=biomake prologs -g run bench.pl -j -Qpbs

## Currently working

Ciao, ECLiPSe, GNU Prolog, Scryer, SWI, Trealla.

## Anticipated implementations

Bin, Projog, B, Tu, Tau, SICStus, (if you have purchased the key),
Pop, Doge (JavaScript, Python, Java), Yap, XSB.

## Tried and wouldn't be supported

  * [JLog][a] – only GUI. JScriptLog has stuck in unfinished state from 2007,
    it runs, but it seems to support only hardcoded KB – some development is
    required.
  * [LPA-Prolog][b] – commercial license is needed.
  * [Brain Aid Prolog][c] – can't find sources.
  * [Strawberry Prolog][d] – full IDE no easy way to integrate
    into CLI.
  * [DGKS Prolog][e] – Looks like a someone's toy project from late 90', no CLI
    interface without writing custom Java code, can't handle operators correctly.
  * Turbo Prolog – can't find sources and it seems to be a lot of pain anyways.
    Links:
      * [Turbo Prolog Goodies][f]
  * [Quintus Prolog][g] – sources are paywalled, no real reason to use because
    it's successor SICStus is available.
  * [Minerva Prolog][h] – source code is unobtainium now.
  * [C# Prolog][i] – doesn't support cyclic terms and has non-standard exception
    handling.
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

[a]: https://jlogic.sourceforge.net/ "JLog and JScriptLog sources"
[b]: https://www.lpa.co.uk/ind_pro.htm
[c]: http://www.fraber.de/bap/index.html
[d]: https://dobrev.com/
[e]: https://web.archive.org/web/20090724160647/http://geocities.com/SiliconValley/Campus/7816/
[f]: https://web.archive.org/web/20031203213809/http://perso.wanadoo.fr/colin.barker/tpro/tpro.htm
[g]: https://quintus.sics.se/
[h]: https://web.archive.org/web/20121105020447/http://www.ifcomputer.co.jp/MINERVA/Download/home_en.html
[i]: http://sourceforge.net/projects/cs-prolog/
[j]: http://www.amzi.com/AmziOpenSource/
[k]: https://github.com/heathmanb/JinniProlog
[l]: https://web.archive.org/web/20170717032834/http://www.ifcomputer.de/Products/Prolog/Download/home_de.html
[m]: https://people.cs.kuleuven.be/~Maurice.Bruynooghe/Prolog/Prolog.html
[n]: https://web.archive.org/web/20200223033605/http://www.jekejeke.ch/idatab/doclet/prod/en/docs/05_run/05_down.jsp
[o]: https://github.com/ichiban/prolog
