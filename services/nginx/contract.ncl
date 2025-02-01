let types = import "../../types.ncl" in

types.makeConfiglet {
  input = {
    port | Number | default = 80,
    worker_processes | Number | default = 4,
    ssl_enable | Bool | default = false,
  },

  output.services.nginx = types.ServiceConfig & {
      name = "nginx",
      enable = true,
      config_path = "@nginx@/conf/nginx.conf",
      settings = {
        port = input.port,
        worker_processes = input.worker_processes,
        ssl = if input.ssl_enable then {
          cert = "@nginx@/ssl/cert.pem",
          key = "@nginx@/ssl/key.pem"
        } else null
      }
    },

  meta.maintainers = ["nrdxp"],
  meta.description = "configuration for nginx",
}
