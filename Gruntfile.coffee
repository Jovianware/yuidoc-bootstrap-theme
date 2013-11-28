path = require 'path'

HOSTNAME = process.env.HOSTNAME ? '0.0.0.0'
PORT = process.env.PORT ? 3000

module.exports = (grunt) ->
  config =
    jade:
      options:
        pretty: true
      layouts:
        expand: true
        cwd: 'layouts'
        src: '**/*.jade'
        dest: 'layouts'
        ext: '.handlebars'
      partials:
        expand: true
        cwd: 'partials'
        src: '**/*.jade'
        dest: 'partials'
        ext: '.handlebars'

    stylus:
      assets:
        expand: true
        cwd: 'assets'
        src: '**/*.styl'
        dest: 'assets'
        ext: '.css'

    yuidoc:
      compile:
        name: 'Sample Project'
        description: 'A sample project for testing YUIDoc themes'
        version: '0.1.0'
        url: 'http://example.com/'
        options: 
          paths: ['sample/src']
          outdir: 'sample/doc'
          themedir: '.'
          helpers: ['helpers/helpers.js']
    
    copy:
      assets:
        expand: true
        cwd: 'assets'
        src: '**'
        dest: 'sample/doc/assets'
    
    watch:
      options:
        livereload: true
      jade:
        files: [
          'layouts/**/*.jade'
          'partials/**/*.jade'
        ]
        tasks: ['jade']
      yuidoc:
        files: [
          '**/*.handlebars'
          'helpers/helpers.js'
          'sample/**'
        ]
        tasks: ['yuidoc']
      stylus:
        files: 'assets/**/*.styl'
        tasks: ['stylus']
      html:
        files: '**/*.html'
      assets:
        files: [
          'assets/**/*.jpg'
          'assets/**/*.png'
          'assets/**/*.gif'
          'assets/**/*.css'
          'assets/**/*.js'
        ]
        tasks: ['copy:assets']

    connect:
      server:
        options:
          hostname: HOSTNAME
          port: PORT
          base: 'sample/doc'
          directory: 'sample/doc'
          livereload: true

    open:
      hack:
        path: "http://#{HOSTNAME}:#{PORT}/"

  grunt.initConfig config

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-yuidoc'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-open'

  grunt.registerTask 'default', ['yuidoc']
  grunt.registerTask 'hack', ['jade', 'stylus', 'yuidoc', 'connect:server', 'open:hack', 'watch']
