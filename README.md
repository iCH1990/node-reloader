# node-reloader
auto reloader &amp; start script for node js

## Usage
- Merge with your bin folder.
- Configure your ./bin/www

### Service
- Configure your package.json and add this:
<pre><code>
"scripts": {
      "start": "sh bin/service.sh start",
      "stop": "sh bin/service.sh stop",
      "restart": "sh bin/service.sh restart"
  }
</code></pre>
- Run the command in your application's root path
<pre><code>
npm start
npm stop
npm restart
</code></pre>
- The runtime log with be written in ./bin/runtime.log (you can change the path in service.sh)
<pre><code>
logPath="$path/bin/runtime.log"
</pre></code>
- The pid will be recorded in ./bin/project.pid (you can change the path in service.sh)
<pre><code>
pidPath="$path/bin/project.pid"
</pre></code>

### Auto Reloader
- This feature depends on inotify (download link: [sourceforge](http://sourceforge.net/projects/inotify-tools/))
- Configure which files (folders) you want to monitor
<pre><code>
fileList=(
      'lib'
      'node_modules'
      'config'
      'models'
      'routes'
      'app.js'
)
</code></pre>
- Run the command in your application's root path or bin path
<pre><code>
sh ./bin/autoReload.sh
sh autoReload.sh
</code></pre>
- Your server will be reloaded automatically when the file changes
