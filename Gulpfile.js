var gulp       = require('gulp');
var coffeelint = require('gulp-coffeelint');
var stylus     = require('gulp-stylus');
var uglify     = require('gulp-uglify');

var browserify = require('browserify');
var coffeeify  = require('coffeeify');
var buffer     = require('vinyl-buffer');
var vinyl      = require('vinyl-source-stream');

/* Fonction pour supprimer le repertoire de build sans warnings */
var fs = require('fs');
var deleteFolderRecursive = function(path)
{
  if( fs.existsSync(path) )
  {
    fs.readdirSync(path).forEach(function(file,index)
    {
      var curPath = path + "/" + file;
      if(fs.lstatSync(curPath).isDirectory())
      {
        deleteFolderRecursive(curPath);
      }
      else
      {
        fs.unlinkSync(curPath);
      }
    });
    fs.rmdirSync(path);
  }
};

var paths = {
  assets: './app/assets/**/*.*',
  app: './app',
  dist: './dist',
  js: '/js',
  css: './app/css/main.styl',
  mainCoffeeFile: './app/js/app.coffee',
  html: './app/index.html',
  coffeeFiles: './app/js/*.coffee'
};

var htmlOutput = 'index.html';

/* Permet de vérifier le code .coffee */
gulp.task('lint', function() {
  return gulp.src(paths.coffeeFiles)
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())
    .pipe(coffeelint.reporter('failOnWarning'));
});

/* Supprime le repertoire de build */
gulp.task('clean', function(cb) {
    deleteFolderRecursive(paths.dist);
});

/* Copie les 'assets' du jeu */
gulp.task('copy-assets', function() {
  return gulp.src(paths.assets, {base: paths.app})
    .pipe(gulp.dest(paths.dist));
});

/* Compile le code css (compression) */
gulp.task('compile-css', function() {
  return gulp.src(paths.css)
    .pipe(stylus({
      compress: true
    }))
    .pipe(gulp.dest(paths.dist));
});

/* Compile le code .coffee en .js (compression) */
gulp.task('compile-js', function() {
  /* browserify rend un code qui n'est pas "debuggable" */
  return browserify(paths.mainCoffeeFile)
    .transform(coffeeify)
    .bundle()
    .pipe(vinyl('main.js'))
    .pipe(buffer())
    .pipe(uglify())
    .pipe(gulp.dest(paths.dist));
});

/* Copie le fichier html */
gulp.task('copy-html', function()
{
  return gulp.src(paths.html)
    .pipe(gulp.dest(paths.dist));
});

/* Methodes qui vont etre appellees par npm */
gulp.task('build', ['clean', 'copy-assets', 'compile-css', 'compile-js', 'copy-html']);
gulp.task('default', ['clean']);
