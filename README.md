# Nickel-Nix Configuration Prototype

A minimal example demonstrating type-safe configuration with Nickel and Nix store path injection.

## Key Components

- **Service Contracts**: [`services/nginx/contract.ncl`](services/nginx/contract.ncl)
  Defines input/output interfaces with type validation
- **Profile Overrides**: [`services/nginx/profiles`](services/nginx/profiles)
  Implements Saab-style priority merging:
  - [`security.ncl`](services/nginx/profiles/security.ncl) - Force SSL enablement
  - [`network.ncl`](services/nginx/profiles/network.ncl) - Port override
- **Core Types**: [`types.ncl`](types.ncl)
  Base configuration contracts
- **Nix Integration**: [`ninject.nix`](ninject.ncl)
  Pure path substitution without DSL

## Usage

1. **Export Nickel Configuration**:
   ```
   nickel export services/nginx/final.ncl > config.json
   ```
2. **Inject Nix Store Paths**:
   ```
   ./run.sh services/nginx | jq
   ```

## Example Output

```
{
  "services": {
    "nginx": {
      "config_path": "/nix/store/.../nginx.conf",
      "settings": {
        "port": 8080,
        "ssl": {
          "cert": "/nix/store/.../cert.pem",
          "key": "/nix/store/.../key.pem"
        }
      }
    }
  }
}
```

## Key Features

- **Type-Driven Validation** - Contracts enforce config structure before Nix sees it
- **Lazy Composition** - Profiles merge via Nickel's native `&` operator
- **Pure Path Injection** - Simple regex replacement in [`ninject.ncl`](ninject.ncl)
- **Team Scalability** - Profile system allows isolated overrides

## TODO for MVP

- **Flesh out types** - Types are barebones for demonstration purposes, but could be fleshed out to provide more structure
- **Expand Example** - Write a few more services to demonstrate how services might interact
- **Implement Library Code** - Write library functions to automate the Nickel profile merging and high-level service merging
- **Build an Output** - Build an actual derivation based on the generated configuration, demonstrating how one might build individual services, or even an entire system

[Nickel Documentation](https://nickel-lang.org) | [Nix Manual](https://nixos.org/manual/nix/stable)
