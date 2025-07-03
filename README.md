# Dokku API Integration

This project provides a custom API to interact with Dokku, a platform for deploying and managing applications. The API is built using Ruby on Rails and offers endpoints for managing applications, processes, logs, domains, and configurations on a Dokku server.

### I made this service for a PoC for [Miqor](https://miqor.app) when it was done with Dokku. But I moved to K8s entirely and wrote this service again in Go to suite my needs. Treat this as a PoC. It might work for you. A lot of features are lacking which the official Dokku API has (but this one is free though).

## Features

- **Application Management**: Create, destroy, rename, and deploy applications.
- **Process Management**: Start, stop, restart, rebuild, and scale processes.
- **Log Management**: Retrieve application logs.
- **Domain Management**: Add and remove domains for applications.
- **Configuration Management**: Set and unset environment variables for applications.

## Requirements

- Ruby 3.x
- Rails 7.x
- Redis for sidekiq
- Traefik if you want to use the routing features
- Dokku installed on the target server
- SSH access to the Dokku server

Follow the [Dokku documentation](https://dokku.com/docs/) for installation and setup instructions for Dokku.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Nuzair46/Ueno-rb.git
   cd Ueno-rb
   ```

2. Prepare:
   ```bash
   bin/setup
   ```

3. Configure environment variables:
   Create a `.env` file and set the following variables:
   ```env
   DOMAIN=example.com
   UENO_TOKEN=test_token
   DOKKU_SSH_HOST_NAME=dokku@example.com
   DOKKU_SSH_PRIVATE_KEY=path/to/private/key
   ```

4. Start the app:
   ```bash
   foreman start -f Procfile  
   ```

## API Endpoints

### Applications

- `POST /api/v1/apps/create`: Create a new application.
- `POST /api/v1/apps/destroy`: Destroy an application.
- `POST /api/v1/apps/rename`: Rename an application.
- `POST /api/v1/apps/deploy`: Deploy an application.
- `GET /api/v1/apps/urls`: Retrieve application URLs.

### Processes

- `POST /api/v1/procs/rebuild`: Rebuild application processes.
- `POST /api/v1/procs/restart`: Restart application processes.
- `POST /api/v1/procs/start`: Start application processes.
- `POST /api/v1/procs/stop`: Stop application processes.
- `POST /api/v1/procs/scale`: Scale application processes.
- `POST /api/v1/procs/report`: Retrieve process reports.

### Logs

- `GET /api/v1/logs/show`: Retrieve application logs.

### Domains

- `POST /api/v1/domains/add`: Add a domain to an application.
- `POST /api/v1/domains/remove`: Remove a domain from an application.

### Configurations

- `POST /api/v1/configs/set`: Set an environment variable.
- `POST /api/v1/configs/unset`: Unset an environment variable.

## Authentication

The API uses an `X-Auth-Token` header for authentication. The token is validated against the `UENO_TOKEN` environment variable.

## Deployment

To deploy the API, use Dokku or any other deployment platform compatible with Rails applications. Ensure the environment variables are correctly set on the server.

## Contributing

Contributions are welcome!

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Support

I probably won't support this project anymore. If you have any issues, feel free to open an issue on GitHub, but I might not respond promptly.
