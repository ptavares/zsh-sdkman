![GitHub](https://img.shields.io/github/license/ptavares/zsh-exa)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
![Release](https://img.shields.io/badge/Release_version-0.0.0-blue)

# zsh-sdkman

zsh plugin for installing and loading [sdkman](https://github.com/sdkman)

This plugin come with completion scripts and aliases

## Table of content

_This documentation section is generated automatically_

<!--TOC-->

- [zsh-sdkman](#zsh-sdkman)
  - [Table of content](#table-of-content)
  - [Dependencies](#dependencies)
  - [Usage](#usage)
    - [Usage help](#usage-help)
    - [Usage alias](#usage-alias)
  - [Updating sdkman](#updating-sdkman)
  - [License](#license)

<!--TOC-->

## Dependencies

As this plugin install [sdkman](https://github.com/sdkman), you'll need some packages to ensure this plugin to work :

- `bash`
- `zip`
- `unzip`
- `curl`

## Usage

Once the plugin installed, `sdkman` will be available

- Using [Antigen](https://github.com/zsh-users/antigen)

Bundle `zsh-sdkman` in your `.zshrc`

```shell
antigen bundle ptavares/zsh-sdkman
```

- Using [zplug](https://github.com/b4b4r07/zplug)

Load `zsh-sdkman` as a plugin in your `.zshrc`

```shell
zplug "ptavares/zsh-sdkman"
```

- Using [zgen](https://github.com/tarjoilija/zgen)

Include the load command in your `.zshrc`

```shell
zget load ptavares/zsh-sdkman
```

- As an [Oh My ZSH!](https://github.com/robbyrussell/oh-my-zsh) custom plugin

Clone `zsh-sdkman` into your custom plugins repo and load as a plugin in your `.zshrc`

```shell
git clone https://github.com/ptavares/zsh-sdkman.git ~/.oh-my-zsh/custom/plugins/zsh-sdkman
```

```shell
plugins+=(zsh-sdkman)
```

Keep in mind that plugins need to be added before `oh-my-zsh.sh` is sourced.

- Manually

Clone this repository somewhere (`~/.zsh-sdkman` for example) and source it in your `.zshrc`

```shell
git clone https://github.com/ptavares/zsh-sdkman ~/.zsh-sdkman
```

```shell
source ~/.zsh-sdkman/zsh-sdkman.plugin.zsh
```

### Usage help

Sdkman can be used as usual:

```bash
Usage: sdk <command> [candidate] [version]
       sdk offline <enable|disable>

   commands:
       install   or i    <candidate> [version] [local-path]
       uninstall or rm   <candidate> <version>
       list      or ls   [candidate]
       use       or u    <candidate> <version>
       default   or d    <candidate> [version]
       home      or h    <candidate> <version>
       env       or e    [init]
       current   or c    [candidate]
       upgrade   or ug   [candidate]
       version   or v
       broadcast or b
       help
       offline           [enable|disable]
       selfupdate        [force]
       update
       flush             <broadcast|archives|temp>

   candidate  :  the SDK to install: groovy, scala, grails, gradle, kotlin, etc.
                 use list command for comprehensive list of candidates
                 eg: $ sdk list
   version    :  where optional, defaults to latest stable if not provided
                 eg: $ sdk install groovy
   local-path :  optional path to an existing local installation
                 eg: $ sdk install groovy 2.4.13-local /opt/groovy-2.4.13
```

### Usage alias

Here is the list of aliases available through this plugin:

| Alias         | Command     |
| ------------- |-------------|
| sdki | sdk install    |
| sdkun | sdk uninstall |
| sdkls | sdk list  |
| sdku | sdk use  |
| sdkd | sdk default  |
| sdkc | sdk current  |
| sdkup | sdk upgrade  |
| sdkv | sdk version  |
| sdkb | sdk broadcast  |
| sdko | sdk offline  |
| sdksu | sdk selfupdate|
| sdkf | sdk flush  |

## Updating sdkman

The plugin comes with a zsh function to update [sdkman](https://github.com/sdkman) manually

```shell
# From zsh shell
update_zsh_sdkman
```

## License

[MIT](LICENCE)
