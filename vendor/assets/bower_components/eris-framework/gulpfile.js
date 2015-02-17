var gulp = require('gulp'),
    sass = require('gulp-ruby-sass'),
    minifycss = require('gulp-minify-css'),
    jshint = require('gulp-jshint'),
    uglify = require('gulp-uglify'),
    imagemin = require('gulp-imagemin'),
    rename = require('gulp-rename'),
    clean = require('gulp-clean'),
    concat = require('gulp-concat'),
    notify = require('gulp-notify'),
    cache = require('gulp-cache');


gulp.task('default', ['clean', 'eris-core', 'eris-angular', 'eris-angular-javascript', 'promo', 'fonts', 'watch']);

gulp.task('eris-core', function() {
    return gulp.src(['bower_components/normalize-css/normalize.css','src/eris-core/main.scss'])
        .pipe(sass({ style: 'expanded' }))
        .pipe(concat('main.css'))
        .pipe(gulp.dest('dist/eris-core'))
        .pipe(rename({suffix: '.min'}))
        .pipe(minifycss())
        .pipe(gulp.dest('dist/eris-core'));
});


gulp.task('eris-angular', function() {
    return gulp.src('src/eris-angular/main.scss')
        .pipe(sass({ style: 'expanded' }))
        .pipe(gulp.dest('dist/eris-angular'))
        .pipe(rename({suffix: '.min'}))
        .pipe(minifycss())
        .pipe(gulp.dest('dist/eris-angular'));
});

gulp.task('promo', function() {
   return gulp.src('src/eris-core/promo-main.scss')
       .pipe(sass({ style: 'expanded' }))
       .pipe(gulp.dest('dist/promo'));
});

gulp.task('eris-angular-javascript', function() {
    return gulp.src('src/js/**/*.js')
        .pipe(concat('main.js'))
        .pipe(gulp.dest('dist/js'))
        .pipe(rename({suffix: '.min'}))
        .pipe(uglify())
        .pipe(gulp.dest('dist/js'))
        .pipe(notify({ message: 'Scripts task complete' }));
});

gulp.task('fonts', function() {
   return gulp.src('src/css/font/*')
       .pipe(gulp.dest('dist/css/font'));
});

gulp.task('clean', function() {
    return gulp.src(['dist/css', 'dist/js', 'dist/images'], {read: false})
        .pipe(clean());
});

gulp.task('watch', function() {

    // Watch .scss files
    gulp.watch('src/eris-core/**/*.scss', ['eris-core']);

    gulp.watch('src/eris-angular/**/*.scss', ['eris-angular']);

    // Watch .js files
    gulp.watch('src/js/**/*.js', ['eris-angular-javascript']);

    // Watch image files
    gulp.watch('src/images/**/*', ['images']);

});
