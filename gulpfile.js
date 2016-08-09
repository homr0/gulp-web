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

// Gulp spins up a server using Browser Sync.
gulp.task('browserSync', function() {
    browserSync.init({
        server: {
            baseDir: 'src'
        },
    })
})

// Gulp converts SCSS files into CSS files.
gulp.task('sass', function() {
    return gulp.src('src/scss/**/*.scss')
    .pipe(sass())
    .pipe(gulp.dest('src/css'))
    .pipe(browserSync.reload({
        stream: true
    }))
});

// Concatenates and minifies CSS and JavaScript files.
gulp.task('useref', function() {
    return gulp.src('src/partials/*.html')
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
    .pipe(cache(imagemin({
        // Setting interlaced to true.
        interlaced: true
    })))
    .pipe(gulp.dest('dist/images'))
});

// Copies fonts over to dist
gulp.task('fonts', function() {
    return gulp.src('src/fonts/**/*')
    .pipe(gulp.dest('dist/fonts'))
}

// Feeds Panini a stream of HTML files to get flattened site.
gulp.task('panini', function() {
    gulp.src('pages/**/*.html')
    .pipe(panini({
        root: 'src/',
        layouts: 'layouts/',
        partials: 'partials/',
        data: 'data/'
    }))
    .pipe(gulp.dest('dist'))
});

// Cleans up all automatically generated files.
gulp.task('clean:dist', function() {
    return del.sync('dist');
})

// Clears the cache off of the local system.
gulp.task('cache:clear', function() {
    return cache.clearAll(callback)
})

// Gulp watches for changes and then reloads browser.
gulp.task('watch', ['browserSync', 'sass'], function() {
    gulp.watch('src/scss/**/*.scss', ['sass']);
    gulp.watch('src/**/*.html', browserSync.reload);
    gulp.watch(['src/{layouts,partials,data}/**/*'], [panini.refresh]);
    gulp.watch('src/js/**/*.js', browserSync.reload);
});

// Gulp builds everything with a sequence of events.
gulp.task('build', function(callback) {
    runSequence('clean:dist', 
        ['sass', 'useref', 'images', 'fonts', 'panini'], 
        callback
    )
})

// Default Gulp task
gulp.task('default', function(callback) {
    runSequence(['sass', 'browserSync', 'watch'],
        callback
    )
})
