{
  # Base service configuration type
  ServiceConfig = {
    name | String,
    enable | Bool | default = true,
  },

  # Generic configlet contract
  Configlet = {
    input,
    output,
    meta | { description | String, .. }
  },

  # Helper function to validate configlet structure
  makeConfiglet = fun cfg =>
    cfg | Configlet
}
