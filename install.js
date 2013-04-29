#!/usr/bin/env node

var path = require('path')
  , fs = require('fs')
  , sh = require('shelljs')
  , HOME = process.env.HOME
  , OLD = path.join(HOME, 'old.dot')
  , BASHRC = path.join(HOME, '.bashrc')

sh.mkdir(OLD)
sh.exec('git submodule init', function (code, output) {
  console.log(output)
  sh.exec('git submodule update', {async: true})
})

sh.ls('-A', 'home').forEach(backup)

sh.grep('.bash_aliases', BASHRC) || fs.appendFileSync(BASHRC, '\n. ~/.bash_aliases\n')

sh.cd('./home/.vim/tern')
sh.exec('npm install')


function backup (file) {
  sh.mv(path.join(HOME, file), path.join(OLD, file))
  sym(file)
}

function sym (file) {
  fs.symlink(path.join(__dirname, 'home', file), path.join(HOME, file))
}

