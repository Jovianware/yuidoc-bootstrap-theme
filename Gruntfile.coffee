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
          'assets/**'
        ]
        tasks: ['yuidoc']
      html:
        files: '**/*.html'
      images:
        files: ['sample/doc/**/*.jpg', 'sample/doc/**/*.png', 'sample/doc/**/*.gif']
      css:
        files: 'sample/doc/**/*.css'
      js:
        files: 'sample/doc/**/*.js'

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

  grunt.loadNpmTasks 'grunt-contrib-yuidoc'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-open'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['yuidoc']
  grunt.registerTask 'hack', ['yuidoc', 'connect:server', 'open:hack', 'watch']
