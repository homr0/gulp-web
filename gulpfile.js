'use strict';
var gulp = require('gulp');
var sass = require('gulp-sass');
var browserSync = require('browser-sync');
var useref = require('gulp-useref');
var gulpIf = require('gulp-if');
var uglify = require('gulp-uglify');
var cssnano = require('gulp-cssnano');
var imagemin = require('gulp-imagemin');
var cache = require('gulp-cache');
var del = require('del');
var runSequence = require('run-sequence');
var panini = require('panini');

const reload = browserSync.reload;

// Gulp spins up a server using Browser Sync.
gulp.task('browserSync', function() {
    browserSync.init({
        server: {
            baseDir: 'dist'
        },
    })
})

// Gulp converts SCSS files into CSS files.
gulp.task('sass', function() {
    return gulp.src('src/scss/**/*.scss')
    .pipe(sass())
    .pipe(gulp.dest('dist/css'))
    .pipe(reload({
        stream: true
    }))
});

// Gulp moves JavaScript over.
gulp.task('javascript', function() {
    return gulp.src('src/js/**/*.js')
    .pipe(gulp.dest('dist/js'))
});

// Concatenates and minifies CSS and JavaScript files.
gulp.task('useref', function() {
    return gulp.src('src/**/*.(html|hbs)')
    .pipe(useref())
    // Minifies only if it's a JavaScript file.
    .pipe(gulpIf('*.js', uglify()))
    // Minifies only if it's a CSS file.
    .pipe(gulpIf('*.css', cssnano()))
    .pipe(gulp.dest('dist'))
});

// Minifies and optimizes images.
gulp.task('images', function() {
    return gulp.src('src/images/**/*.+(png|jpg|jpeg|gif|svg)')
    .pipe(cache(imagemin()))
    .pipe(gulp.dest('dist/images'))
});

// Copies fonts over to dist
gulp.task('fonts', function() {
    return gulp.src('src/fonts/**/*')
    .pipe(gulp.dest('dist/fonts'))
});

// Feeds Panini a stream of HTML files to get flattened site.
gulp.task('pages', function() {
    gulp.src('src/pages/**/*.+(html|hbs)')
    .pipe(panini({
        root: 'src/',
        layouts: 'src/layouts/',
        partials: 'src/partials/',
        helpers: 'src/helpers/',
        data: 'src/data/'
    }))
    .pipe(gulp.dest('dist'))
    .pipe(reload({
        stream: true
    }));
});

// Cleans up all automatically generated files.
gulp.task('clean:dist', function() {
    return del.sync('dist');
})

// Clears the cache off of the local system.
gulp.task('cache:clear', function() {
    return cache.clearAll(callback)
})

// Gulp resets pages when html is changed.
gulp.task('pages:reset', function(done) {
    panini.refresh();
    gulp.watch('pages');
    done();
});

// Gulp watches for changes and then reloads browser.
gulp.task('watch', ['browserSync', 'sass'], function() {
    gulp.watch('src/scss/**/*.scss', ['sass']);
    gulp.watch('src/pages/**/*.html', ['pages']);
    gulp.watch(['src/{layouts,partials,helpers,data}/**/*'], ['pages:reset']);
    gulp.watch('src/js/**/*.js', ['javascript, reload']);
});

// Gulp builds everything with a sequence of events.
gulp.task('build', function(callback) {
    runSequence('clean:dist',
        ['sass', 'javascript', 'useref', 'images', 'fonts', 'pages'],
        callback
    )
})

// Default Gulp task
gulp.task('default', function(callback) {
    runSequence(['pages', 'sass', 'javascript', 'browserSync', 'watch'],
        callback
    )
})
