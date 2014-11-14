'use strict';

var gulp    = require('gulp');
var coffee  = require('gulp-coffee');
var mocha   = require('gulp-mocha');
var clean   = require('gulp-clean');

gulp.task('clean', function () {
  gulp.src('./app/**/*.js')
    .pipe(clean());
})

gulp.task('coffee',['clean'], function() {
  gulp.src('./src/**/*.coffee')
    .pipe(coffee().on('error', function (err) {
      console.log(err);
    }))
    .pipe(gulp.dest('./app/'))
    .pipe(mocha({
      reporter: 'spec'
    }).on('error', function (err) {
      console.log(err);
    }));
});


gulp.task('default', ['coffee'], function() {
  gulp.watch("./src/**/*.coffee", ['coffee']);
});
