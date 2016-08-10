# gulp-web
A test website that uses the Gulp build tool

# Introduction
This is an exercise in using Gulp to build a website. Besides Gulp for testing this will use Sass for CSS precompiling and Panini for page templating.

# Directory Structure
|- *dist/*

    This is where the built files will be outputted to.

|- *node_modules/*

    The plugins needed to run the project are kept here.

|- *src/*

    |- *css/*

        The built CSS files are here.

    |- *data/*

        Data for use in pages is here.

    |- *fonts/*

        Customized fonts are here.

    |- *images/*

        Images used for the site are here.

    |- *js/*

        JavaScript and jQuery scripts are here.

    |- *layouts/*

        Layouts/templates are here.

    |- *pages/*

        Contains the actual page bodies here.

    |- *partials/*

        The page partials to put into the templates are here.

    |- *scss/*
        SCSS partials are kept here.

|- *gulpfile.js*

    Gulp tasks are kept here.

|- *LICENSE*

|- *package.json*
    Information about the project and list of dependencies is here.

|- *README.md*
    Information about the project is here.

# Dependencies
*gulp-sass* - Compiles Sass into CSS.

*browser-sync* - Spins up a web server that helps do live-reloading.

*gulp-useref* - Concatenates CSS and JavaScript.

*gulp-if* - Conditionally controls the flow of objects.

*gulp-uglify* - Minifies JavaScript files.

*gulp-cssnano* - Minifies CSS files.

*gulp-imagemin* - Minifies PNG, JPEG, GIF, and SVG images.

*gulp-cache* - Creates a temp file for caching.

*del* - Deletes automatically generated files.

*run-sequence* - Ensures that a glob of tasks is run in a sequence.

*panini* - Assembles flat files into pages.

# Gulp Tasks
*gulp* - Compiles the Sass, launches the Browser Sync, and watches for any changes.

*gulp build* - Cleans up any files that were generated before, compiles Sass, concatenates and minifies JavaScript and CSS, optimizes images, copies fonts, and flattens partials and layouts into pages.

*gulp watch* - Watches for any changes in Sass, HTML, and/or JavaScript and reloads the browser at any changes.


