"use strict"

# -- DEPENDENCIES --------------------------------------------------------------
gulp    = require 'gulp'
concat  = require 'gulp-concat'
header  = require 'gulp-header'
flatten = require 'gulp-flatten'
uglify  = require 'gulp-uglify'
gutil   = require 'gulp-util'
stylus  = require 'gulp-stylus'
yml     = require 'gulp-yml'
pkg     = require './package.json'

# -- FILES ---------------------------------------------------------------------
assets = 'assets/css/'
theme = [ 'bower_components/stylmethods/vendor.styl'
          'theme/constants.styl'
          # ATOMS
          'theme/atoms/*.styl'
          # FLEXO
          'theme/flexo/flexo.theme.styl'
          'theme/flexo/flexo.page.styl'
          'theme/flexo/flexo.page.*.styl']

banner = [
  '/**'
  ' * <%= pkg.name %> - <%= pkg.description %>'
  ' * @version v<%= pkg.version %>'
  ' * @link    <%= pkg.homepage %>'
  ' * @author  <%= pkg.author.name %> (<%= pkg.author.site %>)'
  ' * @license <%= pkg.license %>'
  ' */'
  ''].join('\n')

# -- TASKS ---------------------------------------------------------------------
gulp.task 'styl', ->
  gulp.src(theme)
    .pipe(concat(pkg.name + '.styl'))
    .pipe(stylus({compress: true, errors: true}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(assets))

gulp.task 'init', ->
  gulp.run(['styl'])

gulp.task 'default', ->
  gulp.watch(theme, ['styl'])
