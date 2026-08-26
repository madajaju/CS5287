# Overlay VPN Networking with Headscale and ZeroTier

Video: https://youtu.be/iojb_8GOt8c

In this lecture we’ll explore how to build private, self-hosted overlay VPNs using Headscale (an open-source Tailscale control server) and compare that to managed, peer-to-peer meshes like ZeroTier. We’ll cover core concepts, architecture, setup, use cases, security considerations, and pros/cons of each approach.

---

## 1. Introduction to Overlay VPNs

**Definition**  
An overlay VPN creates a virtual network “on top of” existing IP networks. Nodes appear to be on the same LAN regardless of their physical location.

**Key Characteristics**
- End-to-end encryption (WireGuard, TLS, DTLS)
- Peer-to-peer or mediated mesh topologies
- NAT traversal: UDP hole-punching or relay servers
- Crypto-authenticated identity rather than IP-based ACLs

**Why Overlay?**
- Simplifies multi-site connectivity without reconfiguring routers
- Enables zero-trust architectures: each node authenticates to a control plane
- Works over any IP-capable network (Internet, cellular, guest Wi-Fi)

---

## 2. Core Components & Terminology

1. **Control Plane**
    - Manages node registration, keys, policies, and network coordinates
    - Headscale acts as an open-source control plane for WireGuard clients
    - ZeroTier’s cloud serves as its control plane by default (optional self-hosted controllers)

2. **Data Plane**
    - Peer-to-peer encrypted tunnel (WireGuard for Headscale; custom UDP/TCP for ZeroTier)
    - Direct NAT-traversal or relayed hops (DERP in Tailscale / STUN in ZeroTier)

3. **Identity & Authentication**
    - Each node has a cryptographic keypair
    - Control plane signs and distributes public keys and network membership
    - Policies govern which nodes can talk to each other

4. **Networks & Subnets**
    - Virtual networks (e.g., 100.x.y.z/24) assigned by control plane
    - Subnet routes enable entire LANs to be advertised over the overlay

---

## 3. Headscale: Self-Hosted WireGuard Control

### 3.1 Architecture & Workflow
1. **Headscale Server**
    - Manages user accounts, namespaces (“namespaces” ≈ Tailscale ACL groups), and keys
2. **Clients**
    - Standard Tailscale “tailscaled” binaries configured to point at Headscale
3. **Registration Flow**
    - User logs into Headscale’s web/UI or issues `headscale users create`
    - Client runs `tailscale up --login-server=https://headscale.example.com`
    - Headscale issues WireGuard keys and network config

### 3.2 Setup Steps (Overview)
1. Deploy Headscale (Docker/Kubernetes/binary)
2. Configure database (SQLite/PostgreSQL) and DNS names
3. Generate a CLI or web UI admin user
4. Install Tailscale clients on endpoints
5. Run `tailscale up` against your Headscale instance
6. Define ACLs (which users can access which subnets/services)

### 3.3 Benefits & Trade-Offs
- **Pros**
    - Full control over data, metadata, and registration
    - No external dependency or lock-in
    - Customizable ACLs, SSO integration, audit logging
- **Cons**
    - You operate and secure the control plane
    - Requires familiarity with WireGuard and Kubernetes/containers
    - Upgrades and scaling are your responsibility

---

## 4. ZeroTier: Managed & Self-Hosted Hybrid

### 4.1 Architecture & Workflow
1. **ZeroTier Network Controller**
    - Default: ZeroTier’s cloud controller
    - Self-hosted: install & run the “ZeroTier Central” or open-source controller
2. **ZeroTier Edge Clients**
    - Lightweight daemon runs on Linux, Windows, macOS, iOS, Android
3. **Registration Flow**
    - Client joins network ID; admin authorizes membership in Central UI
    - Controller issues identity and network config

### 4.2 Setup Steps (Overview)
1. Sign up for ZeroTier Central (or deploy self-hosted controller)
2. Create a network and note its 16-digit network ID
3. Install ZeroTier on each endpoint
4. Run `zerotier-cli join <networkID>`
5. Authorize the node in Central or your self-hosted UI
6. (Optional) Configure managed routes to subnets

### 4.3 Benefits & Trade-Offs
- **Pros**
    - Simple “join network” model; minimal ops overhead
    - Automatic NAT traversal and relays
    - Rich network features: VLANs, managed routes, flow rules
- **Cons**
    - Default controller is a black box in the cloud
    - Self-hosting the controller is possible but less documented
    - Limited direct SSO and enterprise integrations

---

## 5. Comparative Analysis

| Feature                    | Headscale + Tailscale      | ZeroTier (Managed)         | ZeroTier (Self-Hosted)     |
|----------------------------|----------------------------|----------------------------|----------------------------|
| Control Plane Ownership    | You                         | ZeroTier, Inc.             | You                         |
| Data Collection            | None by vendor             | Metadata & coordinates     | None by vendor             |
| Ease of Setup              | Moderate (custom axis)     | Very easy                  | Moderate                   |
| Protocol                   | WireGuard                  | Custom UDP/TCP overlay     | Custom UDP/TCP overlay     |
| NAT Traversal              | UDP hole-punch + DERP      | STUN + relay               | STUN + relay               |
| ACL & Policy Flexibility   | High (YAML ACLs)           | Moderate (flow rules)      | Moderate (flow rules)      |
| Auditing & SSO             | Supported via OIDC/SAML    | Limited                    | You integrate externally   |
| Performance                 | Native WireGuard speeds    | Good; protocol overhead    | Good; protocol overhead    |

---

## 6. Security Considerations

1. **Key Management**
    - Rotate control-plane certificates and WireGuard key pairs
    - Use HSM or KMS for long-term key storage

2. **Network Segmentation**
    - Leverage Headscale namespaces or ZeroTier flow rules to isolate zones
    - Implement least-privilege: limit access to required services

3. **Audit & Monitoring**
    - Enable logging of join events, policy changes, and IP assignments
    - Integrate with SIEM (e.g., Splunk, ELK)

4. **High Availability**
    - Headscale: run multiple instances behind a load balancer, use shared DB
    - ZeroTier self-hosted: cluster controllers or deploy active/passive

---

## 7. Use Cases & Scenarios

1. **Remote Team Connectivity**
    - Provide each developer with a secure overlay network to access internal services (databases, dev servers) without VPN appliances.

2. **IoT & Edge Devices**
    - Headscale for private sensor networks; devices can join at scale with registered keys.
    - ZeroTier for distributed devices where zero-ops provisioning is critical.

3. **Multi-Cloud / Hybrid Cloud**
    - Use overlay to stitch VPCs across AWS, GCP, Azure without complex VPC peering or transit gateways.

4. **Disaster Recovery**
    - Pre-configure overlay nodes to auto-reconnect to DR sites if primary datacenter goes offline.

---

## 8. Best Practices & Recommendations

1. **Secure Your Control Plane**
    - Enforce MFA, network restrictions, and TLS everywhere.
2. **Automate Certificate & Key Rotation**
    - Use scripts or orchestration tools to renew and deploy rotated keys.
3. **Document & Test Failover**
    - Regularly validate HA control-plane failover and node reconnections.
4. **Monitor Latency & Throughput**
    - Track per-peer and per-link performance; plan for relays if needed.
5. **Plan IP Addressing Carefully**
    - Allocate non-overlapping virtual subnets to avoid routing conflicts with on-premises networks.

---

## 9. Next Steps & Hands-On

1. **Deploy a Headscale Proof-of-Concept**
    - Spin up Headscale in Docker/K8s and join 2–3 endpoints.
2. **Experiment with ACLs**
    - Create multiple namespaces/users, test cross-namespace isolation.
3. **Try ZeroTier Managed & Self-Hosted**
    - Compare join flows, policy configuration, and performance.
4. **Integrate with CI/CD**
    - Automate client provisioning (e.g., pre-register keys for new VMs).
5. **Build a Real-World Scenario**
    - Connect cloud VMs, on-premises servers, and developer laptops in one overlay.

---

Thank you! Questions? Let’s dive into any section or do a live demo.
