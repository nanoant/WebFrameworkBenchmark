var sys = require('sys'), 
    cluster = require('cluster'),
    http = require('http'),
    numCPUs = require('os').cpus().length;

cluster.schedulingPolicy = cluster.SCHED_NONE;
http.globalAgent.maxSockets = 1024;

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
    res.end('Hello World');
  })
  .listen(8080);
}
