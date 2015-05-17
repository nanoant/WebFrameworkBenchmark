var sys = require('sys'), 
    cluster = require('cluster'),
    http = require('http'),
    numCPUs = require('os').cpus().length;

http.globalAgent.maxSockets = 1024;
cluster.schedulingPolicy = cluster.SCHED_NONE;

if (cluster.isMaster) {
  console.log('forking on ' + numCPUs + ' CPUs');
  for (var i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
  cluster.on('exit', function(worker, code, signal) {
    console.log('worker ' + worker.process.pid + ' died');
  });
} else {
  http.createServer(function(req, res) {
    res.writeHead(200);
    res.write('Hello World');
    res.end();
  })
  .on('error', function(e) {
    if (e.code == 'EADDRINUSE') {
      console.log('Failed to bind to port - address already in use ');
      process.exit(1);
    }
    console.log('Error ' + e);
  }) 
  .listen(8080);
}
