# STIWK2124-A3-Group6
# STIWK2124-A3-Group6

## Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed.
- Git installed.

## Deployment Instructions

**1. Clone the repository:**
\`\`\`bash
git clone https://github.com/YOUR-USERNAME/STIWK2124-A3-Group6.git
cd STIWK2124-A3-Group6
\`\`\`

**2. Start the application:**
Run the following command in the root directory to build and start the database and backend:
\`\`\`bash
docker-compose up --build
\`\`\`

**3. Access the services:**
- **Frontend (The Website):** `http://localhost`
- **Backend API:** `http://localhost:8080`
- **Database:** `localhost:3307` (Credentials: root / root)

**4. Stop the application:**
To stop the containers and clean up the network, press `Ctrl+C`, then run:
\`\`\`bash
docker-compose down
\`\`\`

when u want to use docker 
1. Download Docker
2. after clone from github
3. type docker-compose up --build
4. 
