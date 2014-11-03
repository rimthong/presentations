module.exports = (grunt) ->
  port = grunt.option('port') || 8000
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean: ['bower_components', 'vendor', 'dist']

    bower:
      install:
        options:
          targetDir: 'vendor'
          install: true

    concat:
      js:
        src: ['vendor/reveal.js/js/reveal.min.js',
              'vendor/reveal.js/plugin/highlight/highlight.js'
            ]
        dest: 'dist/common/vendor.js'
      css:
        src: ['vendor/reveal.js/css/reveal.min.css',
              'vendor/reveal.js/css/theme/default.css',
              'vendor/reveal.js/lib/css/zenburn.css',
            ]
        dest: 'dist/common/vendor.css'

    connect:
      server:
        options:
          port: port
          base: 'dist'

    #XXX Add files here when you make new presentations
    jade:
      html:
        files:
          'dist/docker/index.html': ['src/docker/index.jade']
        options:
          pretty: true

    stylus:
      compile:
        files:
          'dist/common/presentation.css': ['src/front/css/presentation.styl']

    copy:
      font:
        files: [expand: true, flatten: true, src: ['vendor/reveal.js/lib/font/*'], dest: 'dist/common/lib/font']
      img:
        files: [expand: true, flatten: true, src: ['components/bootstrap/img/*.png', 'images/*.png'], dest: 'dist/common/public/img']
      images:
        files: [expand: true, flatten: false, src: ['images/**/*.png'], dest: 'dist/']

    watch:
      jade:
        files: 'src/**/*.jade'
        tasks: ['build']
      stylus:
        files: 'src/**/*.styl'
        tasks: ['build']

  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'build', ['stylus', 'concat', 'jade', 'copy:font', 'copy:images']
  grunt.registerTask 'serve', ['connect', 'watch']
  grunt.registerTask 'default', ['clean', 'bower', 'build']
