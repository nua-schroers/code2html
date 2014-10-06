code2html
=========

Executive Summary
-----------------

Pretty print source code in various programming languages in HTML.

This is a fork of the `code2html` pretty printer developed by Peter Palfrader. The original distribution can be found at [the official homepage](http://www.palfrader.org/code2html/).

The license is GPLv2 (cf. the included file `LICENSE`).

Features
--------

This fork offers the following features/modifications:
* Replace the older, deprecated `<FONT>`-tags with `<SPAN>`-tags that are configured using CSS. This is currently the preferred way to to syntax highlighting when using HTML.
* The `<B>`, `<STRONG>`, `<I>` and `<U>`-tags are similarly replaced with the appropriate CSS-styles.
* Added a helper script named `refactor_highlighting.py` in Python that can refactor a file generated using the former tags and replace them with CSS-styles in a `<SPAN>`-tag, instead.
* The CORBA IDL-language is now supported with appropriate syntax-highlighting.
* In addition the Forth-language is also supported with appropriate syntax-highlighting.
* The latter two languages can also be used separately as plugins in the original `code2html` project if required.

 **NOTE:** The `refactor_highlighting.py` script may not always do what you want since it changes semantic HTML tags (e.g. `<STRONG>`) to stylistic CSS. There are cases when semantic tags are the correct way to emphasize meaning and there are cases where stylistic highlighting is the way to go. When it comes to pretty printing/syntax highlighting source code, semantic tags should not be used and this script works properly.

Included files
--------------

+ `code2html`: Perl script that performs the actual conversion. See below for usage instructions.
+ `code2html.1`: Man-page style usage instructions.
+ `refactor_highlighting.py`: A code refactoring tool to process older HTML-documents; removes the `<FONT>`-tags and replaces them with contemporary `<SPAN>`-tags and appropriate CSS-styles.
+ `COPYING`, `LICENSE`: Licensing and copyright administriva.
+ `Changelog`, `CREDITS`: Credits and changelog.
+ `README`, `INSTALL`, `README.md`: Installation instructions.
+ `plugins`: (Optional) Directory with two plugins for the CORBA IDL- and Forth-languages. These are intended only as plugins when using the original `code2html`. They are already included in the `code2html` in this repository.

Installation
------------

1. If your perl interpreter is not `/usr/bin/perl` (do a `which perl` or `type -a perl`) you will have to change the first line in `code2html` to reflect your location.
2. To install `code2html` on your system, copy the `code2html` file itself to `/usr/local/bin/` and make sure it has mode 755 (this can be done using `sudo chmod 755 /usr/local/bin/code2html`).
3. (Optional) Then copy `code2html.1` to your `man1` directory. On some Linux systems this can be `/usr/local/man/man1/`. On MacOS X it is `/usr/share/man/man1/`. It needs to have mode 644 (this can be done using `sudo chmod 644 /usr/share/man/man1/code2html.1`).
4. (Optional) If you have older, static HTML files with `<FONT>`-tags you may want to also copy the file `refactor_highlighting.py` to your `/usr/local/bin/` directory and make sure it has mode 755 (this can be done using `sudo chmod 755 /usr/local/bin/refactor_highlighting.py`).

| File | Destination | Mode |
:-- | :-: | --:
`code2html` | `/usr/local/bin/` | 0755
`refachtor_highlighting.py` | `/usr/local/bin/` | 0755
`code2html.1` | `/usr/local/man/man1/` | 0644

Usage
-----

### Invoking code2html

There are three ways to use `code2html`:
* to convert a source-code file to pretty-printed HTML,
* to insert pretty-printed HTML code into an existing HTML file, and
* to use it as a CGI script.
These different modes of operation are now discussed in more detail.

#### Convert a source-code file to HTML.

To convert the `code2html` perl script itself to an HTML file, use

    code2html code2html out.html

The first argument is the source file (where `code2html` takes the source-code to pretty-print from) and the second argument is the destination file. Both the source and destination files are optional. If only one argument is given it will be used as the input filename and output will be written to `stdout`. If no argument is given, input is taken from `stdin` and output written to `stdout`. If either the first and/or second options are `-`, input and/or output is read from/written to `stdin` and `stdout`, respectively.

#### Use `code2html` in patch mode.

This allows you to have inline source code in an HTML file. It can then take this file and replace the source code in the HTML file with its pretty-printed counterpart.

    code2html -p [<input-file> [<output-file>]]

If no file is given, input is read from `stdin` and written to `stdout`. If a single filename is given this file is read and then replaced with the output. If two files are supplied the first one is read from and the second one is written to.

In order to insert source code in a given HTML file, add the following comment line into the HTML file:

    <!-- code2html add [options] <input-file> -->

The file `<input-file>` will be read and pretty-printed output in HTML format will be inserted in the HTML file. The options will be processed just as if `code2html` had been invoked at the command line.

Note that options like `--help` continue to work even here, but it is not smart to use them here. The `--content-type` option is ignored. It is strongly recommended to use the `--language-mode` option in this use case since a failure to detect the language results is more damaging.

Furthermore, it is possible to insert the program's source code dirctly in the HTML file using the following syntax:

    <!-- code2html add [options]
    <source-code goes here>
    -->

#### Use `code2html` as a CGI script.

It is assumed that the `GATEWAY_INTERFACE` environment variable is set and no command line arguments are given. The arguments are instead read either from the query string or from `stdin` (methods `POST` and `GET` are supported).

The `--content-type` is switched automatically and the output is always passed to `stdout`. It is strongly recommended to use the `--language-mode` option.

**DISCLAIMER:** I have personally never used `code2html` as a CGI script and prefer to render static sites. Please cf. the documentation in `code2html.1` and [the official homepage](http://www.palfrader.org/code2html/) for further information on this topic.

### Options of code2html

The following additional command line options are supported:
+ `-l`, `--language-mode`: Specifies the set of regular expressions to use, i.e. the programming language to pretty print. A large number of languages is supported right out of the box, additional ones can be supplied as plugins. A full list of currently supported languages can be obtained by `code2html --modes`. If unspecified, the programming language is determined automatically (which may result in failure or improper highlighting).
+ `-v`, `--verbose`: Print progress information to `stderr`.
+ `-n`, `--linenumbers`: Generate the source code with line numbers.
+ `-N`, `--linknumbers`: Generates the source code with line numbers and adds a link anchor to each line number (which makes it easy to create HTML links to specific lines in the source code).
+ `-P`, `--prefix`: Adds an optional prefix to line number anchors. This is useful if you have multiple listings on the same page and want to generate linked line numbers for each of them.
+ `-t`, `--replace-tabs[=TABSTOP-WIDTH]`: Replace each `TAB`-character with an appropriate amount of spaces to get to the next tabstop. Defaults to a width of 8 characters.
+ `-L`, `--language-file`: Specify an additional language file (plugin) to take the language and outpuf-format definitions from (cf. the section on Files below).
+ `-m`, `--modes`: Print all language modes and output formats currently defined. This option exits immediately without processing any files. If combined with `--language-file` it will also list the language plugins if applicable.
+ `--fallback=LANG`: In case the language mode specified with `--language-mode` is not found then this mode will be used, instead. For example the option `--fallback plain` will guarantee that output is created with no highlighting and may be useful in a script.
+ `-h`, `--help`: Lists instructions and available options and exits afterwards.
+ `-c`, `--content-type`: Prints the line
    Content-Type: text/html
 prior to the rest of the output. This can be useful if generating output as a CGI script.
+ `-o`, `--output-format`: Selects the output format, defaults to `html`. A full list of supported output modes can be obtained by `code2html --modes`.
+ `-H`, `--no-header`: Supresses the template defined by the output format. For example in case of HTML this means that there are no `<HTML>`, `<HEAD>` etc. tags. In this manner, the output can be embedded into an existing HTML page, but not as a stand-alone page.
+ `--template=FILE`: Overrides the default template for the current output format. This can be used to specify a different page template, e.g. for generating a stand-alone page using a site-wide page template. Ignored if combined with the `--no-header` option.
+ `-T`, `--title`: Set the title of the output page. This option only works if the output template supports a title field or tag.
+ `-w`, `--linewidth=WIDTH`: Wrap lines after `WIDTH` characters. Defaults to not wrap lines at all.
+ `-b`, `--linebreakprefix=LINEPREFIX`: Use `LINEPREFIX` at the start of wrapped lines. Defaults to ">> ".

### Files

Configuration options for `code2html` can be stored in several places:
1. The file specified by `--language-file`.
2. The files specified in the `CODE2HTML_CONFIG` environment variable separated by colons.
3. The file `$USER/.code2html.config` in the user's directory.
4. The file `/etc/code2html.config` in the system-wide `/etc` directory.
Lower entries in this list correspond to higher priority when defining options. All files must contain valid Perl code.

You should not redeclare the global variables `LANGUAGE` and `STYLESHEET`.

When adding custom language or output configurations start at the built-in definitions at the bottom of `code2html` and use those definitions as a starting point.

### Refactor highlighting

Invoke the script by

    refactor_highlighting.py <input-file> > <output-file>

The input is read from the file which is given in the first and only
command line option. Output is written to stdout and can be piped to a
file using `>`.

