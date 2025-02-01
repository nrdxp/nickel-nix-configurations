let nginx = import "contract.ncl" in
let security = import "profiles/security.ncl" in
let network = import "profiles/network.ncl" in
nginx & security & network
