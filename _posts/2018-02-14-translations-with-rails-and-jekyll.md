---
title: Translations With Rails And Jekyll
date: 2018-02-14 00:00:00 Z
---

I've been adding translations to open source [Ruby on Rails](http://rubyonrails.org) and [GitHub Pages](https://pages.github.com) (i.e. GitHub hosted [Jekyll](https://jekyllrb.com)) sites I maintain. For Rails there's [a fantastic Rails internationalisation guide](http://guides.rubyonrails.org/i18n.html) which walks you through everything you'd want to know. For GitHub Pages there's no such similarly standard resource. Plugins such as [Anthony-Gaudino/jekyll-multiple-languages-plugin](https://github.com/Anthony-Gaudino/jekyll-multiple-languages-plugin) are available but aren't supported by GitHub Pages so require checking in outputted HTML. This has always felt disgusting to me and reminds me of my C++ days when people checked binaries into Subversion 😭.

What I wanted was a site translation system that would work consistently across Rails and GitHub Pages and allows at least partial translation through an external non-GitHub tool such as [Transifex](https://www.transifex.com) (recommended to me but I'm sure there are similar alternatives).

## brew.sh

The first of the open source projects that I maintain that had translations was [Homebrew's homepage](https://brew.sh). The original approach people taken here was [committing a new HTML file for each translation](https://github.com/Homebrew/legacy-homebrew/pull/18660/files). It's cool to see the community submitting new translations this way but it led to a lot of HTML duplication between files. **@jaimeMF** [submitted a new approach](https://github.com/Homebrew/legacy-homebrew/pull/18972/files) in 2013 using YAML files to specify the different translations and [YAML front-matter](https://jekyllrb.com/docs/frontmatter/) for the actual translations. This removed the HTML duplication and made it easy to receive new translations from users.

A problem remained though; this approach was custom to Homebrew and didn't support any existing tooling.

## Open Source Friday

[Open Source Friday](https://opensourcefriday.com) launched as a minimal Rails site without any support or expectation of translations. Thanks to the incredible work of **@miurahr** we now have [translation support in the application](https://github.com/ossfriday/ossfriday/pull/138/files) and [a translation of the entire site into Japanese](https://github.com/ossfriday/ossfriday/pull/129/files) (using the approach detailed in the [Rails internationalisation guide](http://guides.rubyonrails.org/i18n.html)). On recommendation we also set up the [Open Source Friday Transifex page](https://www.transifex.com/github-open-source/open-source-friday/dashboard) so people can translate the application without GitHub.

Transifex translates Rails applications by getting you to upload the [`en.yml`](https://github.com/ossfriday/ossfriday/blob/master/config/locales/en.yml) as your base resource and the relevant language resource e.g. [`ja.yml`](https://github.com/ossfriday/ossfriday/blob/master/config/locales/ja.yml) for each of your languages. This got me thinking; if all it's taking is a YAML file in a particular format: why not use this format in Jekyll too?

## brew.sh (v2)

Homebrew's homepage translations were working well but there was a fair bit of duplication. Any new language was hardcoded in `_config.yml` and wasn't translated by Transifex as the translation data was YAML front-matter in HTML files. I decided to [refactor this](https://github.com/Homebrew/homebrew.github.io/pull/204/files) to have all locale files in `_data/locales/*.yml` (mirroring Rails' `config/locales/*.yml`) as [Jekyll data files](https://jekyllrb.com/docs/datafiles/). I also added a [`t` helper variable](https://github.com/MikeMcQuaid/homebrew.github.io/blob/bc5a12b3c94335a577629dbeffe225d88c000a75/_layouts/index.html#L4) to access translations (again, mirroring the `t` helper method in Rails).

This provided a separation between the translation data in `_data/locales` handled by Transifex, HTML files with minimal front-matter content (`layout` and `lang`) and HTML layout files that use the translations.

## Open Source Guides

Open Source Guides' original system for translations had a repository for each translation. With no merged translations and on the back of the Open Source Friday and Homebrew shared translation efforts I decided to [change the translation approach](https://github.com/github/opensource.guide/pull/543/files) to move all the translations into a single repository, again add a `t` helper variable and use the same location for YAML translations in `_data/locales`.

The main difference with the Open Source Guides is that there are long-form articles written in Markdown instead of HTML pages with sporadic YAML translations. This meant that it made more sense to [provide Markdown files for each language](https://github.com/github/opensource.guide/tree/master/_articles/es) instead of trying to use YAML for majority textual content.

---

My TL;DR on Rails and Jekyll translations:

- For Ruby on Rails sites follow [the Rails internationalization guide](http://guides.rubyonrails.org/i18n.html)
- Use the [Rails localisation file format](https://github.com/github/opensource.guide/blob/master/_data/locales/en.yml) for your GitHub Pages sites to make it easier to use other tools
- Provide a Jekyll `t` helper variable with e.g.:
```liquid
assign t = site.data.locales[page.lang][page.lang]
```
- Use translated Markdown files for text heavy content and translated YAML files for HTML heavy content.
- Keep all your translations in the same repository to allow mass addition of new strings for translation. These can be in English until translated.
- Setup [Transifex](https://www.transifex.com) to allow translators that are less technical to contribute to your project without needing to use GitHub.
