# Deployment & Run Instructions

This guide provides step-by-step instructions for setting up the private GitHub repository and deploying the STIWK2124-A3-Group6 web application locally.

## 1. Initializing the Private GitHub Repository & Access Control

As the lead for Deployment, DevOps, and Repository Setup (Member D), follow these steps to initialize the repository and manage access control:

### Step 1: Create the Repository
1. Log in to [GitHub](https://github.com).
2. Click the **+** icon in the top right corner and select **New repository**.
3. Name the repository (e.g., `STIWK2124-A3-Group6`).
4. Select **Private** to ensure it's a private repository.
5. Do NOT check "Add a README file" or ".gitignore" since these are already created locally.
6. Click **Create repository**.

### Step 2: Push Local Code to GitHub
Open your terminal (or Command Prompt/PowerShell) in the project's root folder (`c:\Users\drago\OneDrive\Documents\Assignment web engineering\A3 TRY 4\STIWK2124-A3-Group6`) and run:

```bash
git remote add origin https://github.com/<your-username>/STIWK2124-A3-Group6.git
git branch -M main
git push -u origin main
```
*(Replace `<your-username>` with your actual GitHub username).*

### Step 3: Manage Access Control (Add Collaborators)
1. Navigate to your repository on GitHub.
2. Click on the **Settings** tab.
3. In the left sidebar, click on **Collaborators**. (You may be prompted to enter your password).
4. Click the **Add people** button.
5. Search for the GitHub usernames or email addresses of your **teammates** and your **lecturer**.
6. Select them and grant them appropriate access. They will receive an email invitation to join the repository.

---

## 2. Local Deployment Guide (Docker)

The project is fully configured to run using Docker. This ensures a reproducible setup across all environments without needing to install Node.js, Java, or MySQL manually on your host machine.

### Prerequisites
- Install [Docker Desktop](https://www.docker.com/products/docker-desktop).
- Ensure Docker is running in the background.

### Step-by-Step Run Instructions

1. **Open your terminal** and navigate to the project root directory.

2. **Start the application** by running the following command:
   ```bash
   docker-compose up --build
   ```
   This command will:
   - Start the MySQL Database (`db`).
   - Build and start the Spring Boot API (`backend`).
   - Build and start the Angular application served by Nginx (`frontend`).

3. **Access the application**:
   - The Frontend application will be accessible at: [http://localhost](http://localhost)
   - The Backend API will be accessible at: [http://localhost:8080](http://localhost:8080)
   - The MySQL database is exposed on port `3307`.

4. **Stopping the application**:
   To stop the application, press `Ctrl + C` in the terminal where it's running, or run the following command in another terminal from the same folder:
   ```bash
   docker-compose down
   ```

---

## 3. Continuous Integration (CI) Logs & Pipeline

GitHub Actions is configured to automatically test and build your code whenever you push to the `main` branch or open a Pull Request.

- **Backend CI**: Defined in `.github/workflows/backend-ci.yml`. It sets up Java 17 and uses Maven to build and test the Spring Boot application.
- **Frontend CI**: Defined in `.github/workflows/frontend-ci.yml`. It sets up Node 22, installs dependencies, and builds the Angular production bundle.

To view the CI logs:
1. Go to your repository on GitHub.
2. Click on the **Actions** tab.
3. Here you will see a list of all workflow runs. Click on any run to view the detailed logs for the backend or frontend builds.
