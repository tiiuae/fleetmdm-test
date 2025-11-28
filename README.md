# Fleet MDM Server with Let's Encrypt

Fleet MDM server with automatic TLS certificates via Traefik and Let's Encrypt.

## Prerequisites

- Docker and Docker Compose
- A domain name pointing to your server's public IP
- Ports 80 and 443 open on your firewall

## Quick Start

1. **Clone and configure:**
   ```bash
   cp .env.example .env
   ```

2. **Edit `.env` with your values:**
   ```bash
   FLEET_HOSTNAME=fleet.yourdomain.com
   ACME_EMAIL=admin@yourdomain.com
   MYSQL_ROOT_PASSWORD=your-secure-password
   MYSQL_PASSWORD=your-secure-password
   ```

3. **Start the stack:**
   ```bash
   docker compose up -d
   ```

4. **Access Fleet:**
   
   Open `https://fleet.yourdomain.com` in your browser. The first visit will prompt you to create an admin account.

## Architecture

```
Internet → Traefik (80/443) → Fleet (8080) → MySQL/Redis
              ↓
        Let's Encrypt
```

- **Traefik**: Reverse proxy handling TLS termination and automatic certificate renewal
- **Fleet**: MDM server
- **MySQL**: Database backend
- **Redis**: Cache and session storage

## Certificate Renewal

Certificates are renewed automatically by Traefik ~30 days before expiration. No manual intervention required.

## Useful Commands

```bash
# View logs
docker compose logs -f

# View Fleet logs only
docker compose logs -f fleet

# Restart services
docker compose restart

# Stop everything
docker compose down

# Stop and remove volumes (WARNING: deletes all data)
docker compose down -v
```

## Troubleshooting

### Certificate issues
- Ensure your domain resolves to this server's IP
- Check Traefik logs: `docker compose logs traefik`
- Verify ports 80/443 are accessible from the internet

### Fleet not starting
- MySQL takes ~30 seconds to initialize on first run
- Check logs: `docker compose logs fleet`
