#include <microhttpd.h>
#include <string.h>
#include <stdio.h>

static struct MHD_Response *response;
static const char *response_text = "Hello World";

static int ahc_echo(void *cls, struct MHD_Connection *connection,
                    const char *url, const char *method, const char *version,
                    const char *upload_data, size_t *upload_data_size,
                    void **ptr) {
  if (0 != strcmp(method, "GET"))
    return MHD_NO; // unexpected method
  return MHD_queue_response(connection, MHD_HTTP_OK, response);
}

int main(int argc, char *const *argv) {
  struct MHD_Daemon *d;
  response = MHD_create_response_from_buffer(
      strlen(response_text), (void *)response_text, MHD_RESPMEM_PERSISTENT);
  d = MHD_start_daemon(
      // options:
      MHD_USE_SELECT_INTERNALLY | MHD_SUPPRESS_DATE_NO_CLOCK |
          MHD_USE_EPOLL_LINUX_ONLY | MHD_USE_EPOLL_TURBO,
      8080, NULL, NULL, &ahc_echo, NULL,                // main handler
      MHD_OPTION_CONNECTION_TIMEOUT, (unsigned int)120, // timeout
      MHD_OPTION_THREAD_POOL_SIZE, (unsigned int)12,    // pool (threads)
      // MHD_OPTION_URI_LOG_CALLBACK, &uri_logger_cb, NULL,      // logger
      // MHD_OPTION_NOTIFY_COMPLETED, &completed_callback, NULL, // completed
      MHD_OPTION_CONNECTION_LIMIT, (unsigned int)1024, // connections
      MHD_OPTION_END);
  if (d == NULL)
    return 1;
  (void)getc(stdin);
  MHD_stop_daemon(d);
  MHD_destroy_response(response);
  return 0;
}
