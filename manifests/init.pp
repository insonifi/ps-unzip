# == Class: ps-unzip
#
# Unzip package with Windows native capability using PowerShell
#
# === Parameters
#
# Document parameters here.
#
# [*file*]
#   path to ZIP-package
#
#
# [*destination*]
#   path to output directory
#   
# === Examples
#
#  ps-unzip {
#    file   => "c:\archive.zip",
#    destination => "c:\archive"
#  }
#
# === Authors
#
# Andrey Panteleyev <insonifi@gmail.com>
#
# === Copyright
#
# Copyright 2014 Andrey Panteleyev, unless otherwise noted.
#
define ps-unzip (
    $file, #: zip file path
    $destination, #: output directory path
    ) {
    if $::operatingsystem != 'windows'{
       fail("Unsupported OS ${::operatingsystem}")
    }
    debug('Validate file path (${file})')
    validate_string($file)
    validate_re($file, ['\.zip'])
    debug('Validate destination path (${destination})')
    validate_string($destination)
    validate_re($destination, ['[A-Z]:(\\|\/).*'])
    debug('Extracting ${file} to ${destination}')
    $cmd = "\$shell = New-Object -COM Shell.Application; \$zip = \$shell.Namespace('${file}'); New-Item -ItemType Directory -Path '${destination}'; foreach(\$item in \$zip.items()) { \$shell.Namespace('${destination}').CopyHere(\$item) }"

    exec{'Unzip $[file}':
        provider => powershell,
        command => $cmd
    }
}
